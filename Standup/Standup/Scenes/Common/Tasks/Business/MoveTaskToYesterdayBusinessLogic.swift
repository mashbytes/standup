import Foundation

protocol MoveTaskToYesterdayBusinessLogic {
    
    func moveTask(_ task: Task, toYesterdayPositionedAt position: Tasks.MoveTask.Position)

}


protocol DefaultMoveTaskToYesterdayBusinessLogic: MoveTaskToYesterdayBusinessLogic {
    
    var tasks: [Task] { get }
    var taskReorderer: TaskReorderer { get }
    
    func didMoveTask(_ task: Task, causingTasksToBeUpdated updated: [Task])
}

extension DefaultMoveTaskToYesterdayBusinessLogic {
    
    var yesterday: [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .done(let date) where Calendar.current.isDateInYesterday(date): return true
                default: return false
                }
            }
            .sortedByOrder()
    }

    func moveTask(_ task: Task, toYesterdayPositionedAt position: Tasks.MoveTask.Position) {
        let toUpdate = taskReorderer.reorderTasks(yesterday, toInclude: task, atPosition: position) {
            return $0.withCompletedDate(Date().addingTimeInterval(-1.days))
        }
        
        didMoveTask(task, causingTasksToBeUpdated: toUpdate)
    }

}
