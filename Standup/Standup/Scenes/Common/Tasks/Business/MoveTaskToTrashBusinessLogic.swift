import Foundation

protocol MoveTaskToTrashBusinessLogic {
    
    func moveTaskToTrash(request: MoveTask.ToTrash.Request)

}

protocol DefaultMoveTaskToTrashBusinessLogic: MoveTaskToTodayBusinessLogic {
    
    var taskService: TaskService? { get }

    func didMoveTaskToTrash(_ task: Task)
    func didntMoveTask(_ task: Task, toTrashDueTo error: Error)

}

extension DefaultMoveTaskToTrashBusinessLogic where Self: TaskDataStore {
    
    func moveTaskToTrash(request: MoveTask.ToTrash.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }

        taskService?.delete(task.id) { result in
            switch result {
            case .success:
                self.didMoveTaskToTrash(task)
            case .failure(let error):
                self.didntMoveTask(task, toTrashDueTo: error)
            }

        }
    }

}

extension DefaultMoveTaskToTrashBusinessLogic where Self: KeyedTasksDataStore {
    
    func didMoveTaskToTrash(_ task: Task) {
        keyedTasks.removeValue(forKey: task.id)
    }
    
}

extension MoveTask {
    
    struct ToTrash {
        typealias Request = MoveTask.TaskRequest
    }
    
}
