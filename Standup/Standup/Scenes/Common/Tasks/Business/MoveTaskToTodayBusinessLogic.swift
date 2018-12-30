import Foundation

protocol MoveTaskToTodayBusinessLogic {

    func moveTask(_ task: Task, toTodayPositionedAt position: Tasks.MoveTask.Position)
    
}

protocol DefaultMoveTaskToTodayBusinessLogic: MoveTaskToTodayBusinessLogic {
    
    var tasks: [Task] { get }
    var taskReorderer: TaskReorderer { get }

    func didMoveTask(_ task: Task, causingTasksToBeUpdated updated: [Task])
}

extension DefaultMoveTaskToTodayBusinessLogic {
    
    var today: [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .done(let date) where Calendar.current.isDateInToday(date): return true
                case .wip: return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
    func moveTask(_ task: Task, toTodayPositionedAt position: Tasks.MoveTask.Position) {
        func updatedStatus() -> Task.Status {
            switch task.status {
            case .done: return .done(Date())
            default: return .wip
            }
        }
        
        let toUpdate = taskReorderer.reorderTasks(today, toInclude: task, atPosition: position) {
            return $0.withStatus(updatedStatus())
        }
        
        didMoveTask(task, causingTasksToBeUpdated: toUpdate)
    }

}
