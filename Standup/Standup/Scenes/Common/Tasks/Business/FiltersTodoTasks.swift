import Foundation

protocol FiltersTodoTasks {
    
    func todoTasks(from tasks: [Task]) -> [Task]

}

extension FiltersTodoTasks {
    
    func todoTasks(from tasks: [Task]) -> [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .todo: return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
}

