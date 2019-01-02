import Foundation

protocol FiltersDoneTasks {
    
    func doneTasks(from tasks: [Task]) -> [Task]
    
}

extension FiltersDoneTasks {
    
    func doneTasks(from tasks: [Task]) -> [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .done: return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
}


