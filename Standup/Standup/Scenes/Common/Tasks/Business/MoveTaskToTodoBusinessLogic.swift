import Foundation

protocol MoveTaskToTodoBusinessLogic {
    
    func moveTask(_ task: Task, toTodoPositionedAt position: Tasks.MoveTask.Position)

}

protocol DefaultMoveTaskToTodoBusinessLogic: MoveTaskToTodoBusinessLogic {
    
    var tasks: [Task] { get }
    var taskReorderer: TaskReorderer { get }
    
    func didMoveTask(_ task: Task, causingTasksToBeUpdated updated: [Task])

}

extension DefaultMoveTaskToTodoBusinessLogic {
    
    var todo: [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .todo: return true
                default: return false
                }
            }
            .sortedByOrder()
    }

    
    func moveTask(_ task: Task, toTodoPositionedAt position: Tasks.MoveTask.Position) {
        let toUpdate = taskReorderer.reorderTasks(todo, toInclude: task, atPosition: position) {
            return $0.withStatus(.wip)
        }

        didMoveTask(task, causingTasksToBeUpdated: toUpdate)
    }
}
