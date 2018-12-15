import Foundation

protocol EditTaskBusinessLogic {
    
    func editTask(request: Tasks.Edit.Request)
    
}

protocol DefaultEditTaskBusinessLogic: EditTaskBusinessLogic {
    
    var taskService: TaskService? { get }
    
    func didEditTask(_ task: Task)
    func didntEditTask(withIdentifier identifier: Task.ID, dueToError error: Error)

}

extension DefaultEditTaskBusinessLogic where Self: TaskDataStore {
    
    func editTask(request: Tasks.Edit.Request) {
        let identifier = request.identifier
        guard let task = taskForIdentifier(identifier) else {
            didntEditTask(withIdentifier: identifier, dueToError: TaskServiceError.notFound)
            return
        }
        let updated = task.withTitle(request.title)
        taskService?.update(updated) { result in
            switch result {
            case .success(let newTask):
                self.didEditTask(newTask)
            case .failure(let error):
                self.didntEditTask(withIdentifier: identifier, dueToError: error)
            }

        }
    }

    
}
