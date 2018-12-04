import UIKit


protocol DeleteTaskBusinessLogic {
    func deleteTask(request: Tasks.Delete.Request)
}

protocol DeleteTaskDataStore: TaskDataStore {
}

protocol DefaultDeleteTaskBusinessLogic: DeleteTaskBusinessLogic {

    var taskService: TaskService? { get }

    func didDeleteTask(withIdentifier identifier: Tasks.DataPassing.TaskIdentifier)
    func didntDeleteTask(withIdentifier identifier: Tasks.DataPassing.TaskIdentifier, dueToError error: Error)
}

extension DefaultDeleteTaskBusinessLogic {
    
    func deleteTask(request: Tasks.Delete.Request) {
        let identifier = request.identifier
        taskService?.delete(identifier) { result in
            switch result {
            case .success:
                self.didDeleteTask(withIdentifier: identifier)
            case .failure(let error):
                self.didntDeleteTask(withIdentifier: identifier, dueToError: error)
            }
        }
    }

    
}
