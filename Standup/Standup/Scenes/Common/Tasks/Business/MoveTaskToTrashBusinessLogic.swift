import Foundation

protocol MoveTaskToTrashBusinessLogic {
    
    func moveTaskToTrash(_ task: Task)

}

protocol DefaultMoveTaskToTrashBusinessLogic: MoveTaskToTodayBusinessLogic {
    
    func deleteTask(_ task: Task)
}

extension DefaultMoveTaskToTrashBusinessLogic {
    
    func moveTaskToTrash(_ task: Task) {
        deleteTask(task)
    }
    
}
