import Foundation

protocol CompleteTaskBusinessLogic {
    
    func completeTask(request: Tasks.Complete.Request)
    
}

protocol DefaultCompleteTaskBusinessLogic: CompleteTaskBusinessLogic {
    
    var taskService: TaskService? { get }
    
    func didCompleteTask(_ task: Task)
    func didntCompleteTask(withIdentifier identifier: Task.ID, dueToError error: Error)
    
}

extension DefaultCompleteTaskBusinessLogic where Self: TaskDataStore {
    
    func completeTask(request: Tasks.Complete.Request) {
        let identifier = request.identifier
        guard let task = taskForIdentifier(identifier) else {
            didntCompleteTask(withIdentifier: identifier, dueToError: TaskServiceError.notFound)
            return
        }
        let completed = task.withCompletedDate(Date())
        taskService?.update(completed) { result in
            switch result {
            case .success(let newTask):
                self.didCompleteTask(newTask)
            case .failure(let error):
                self.didntCompleteTask(withIdentifier: identifier, dueToError: error)
            }
        }
    }
}
