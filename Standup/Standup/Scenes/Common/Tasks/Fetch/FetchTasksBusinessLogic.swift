import Foundation

protocol FetchTasksBusinessLogic {
    
    func fetchTasks(request: Tasks.Fetch.Request)

    
}

protocol DefaultFetchTasksBusinessLogic: FetchTasksBusinessLogic {
    
    var taskService: TaskService? { get }
    
    func didFetchTasks(_ fetched: [Task])
    func didntFetchTasks(dueToError error: Error)
    
}

extension DefaultFetchTasksBusinessLogic {
    
    func fetchTasks(request: Tasks.Fetch.Request) {
        taskService?.retrieve { result in
            switch result {
            case .success(let tasks):
                self.didFetchTasks(tasks)
            case .failure(let error):
                self.didntFetchTasks(dueToError: error)
            }
        }
    }
}
