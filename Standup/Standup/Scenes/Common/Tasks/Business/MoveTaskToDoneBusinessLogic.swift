import Foundation

protocol MoveTaskToDoneBusinessLogic {
    
    func moveTask(_ task: Task, toDonePositionedAt position: Tasks.MoveTask.Position)

}

protocol DefaultMoveTaskToDoneBusinessLogic: MoveTaskToDoneBusinessLogic {
    
    var tasks: [Task] { get }
    var taskReorderer: TaskReorderer { get }
    
    func didMoveTask(_ task: Task, causingTasksToBeUpdated updated: [Task])

}

extension DefaultMoveTaskToDoneBusinessLogic {
    
    var done: [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .done: return true
                default: return false
                }
            }
            .sortedByOrder()
    }

    func moveTask(_ task: Task, toDonePositionedAt position: Tasks.MoveTask.Position) {
        let toUpdate = taskReorderer.reorderTasks(done, toInclude: task, atPosition: position) {
            return $0.withCompletedDate(Date())
        }
        
        didMoveTask(task, causingTasksToBeUpdated: toUpdate)
    }
}
