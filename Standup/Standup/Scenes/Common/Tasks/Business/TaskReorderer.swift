import Foundation

protocol TaskReorderer {
    
    func reorderTasks(_ tasks: [Task], toInclude task: Task, atPosition position: MoveTask.Position, applyingTransformation transformer: (Task) -> Task) -> [Task]
    
}

struct DefaultTaskReorderer: TaskReorderer {
    
    let dataStore: TaskDataStore
    
    func reorderTasks(_ tasks: [Task], toInclude task: Task, atPosition position: MoveTask.Position, applyingTransformation transformer: (Task) -> Task) -> [Task] {
        let ordered = Set(tasks).subtracting([task]).sortedByOrder()
        let updatedTask = transformer(task)
        
        func reorderTasksForPosition() -> [Task] {
            switch position {
            case .first: return ([updatedTask] + ordered)
            case .between(let after, let before):
                guard let afterTask = dataStore.taskForIdentifier(after), let beforeTask = dataStore.taskForIdentifier(before) else {
                    return [updatedTask] + ordered
                }
                
                guard let afterIndex = ordered.firstIndex(of: afterTask), let beforeIndex = ordered.firstIndex(of: beforeTask) else {
                    return [updatedTask] + ordered
                }
                
                return Array(ordered.prefix(through: afterIndex) + [updatedTask] + ordered.suffix(from: beforeIndex))
            case .last:
                return (ordered + [updatedTask])
            }
        }
        
        return reorderTasksForPosition()
            .enumerated()
            .map { offset, next in
                return next.withOrder(offset)
        }
    }

}

extension Sequence where Element == Task {
    
    func sortedByOrder() -> [Element] {
        return sorted { $0.order < $1.order }
    }
    
}
