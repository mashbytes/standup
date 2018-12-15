import UIKit


protocol TodoTasksBusinessLogic {
    func fetchTodoTasks(request: TodoTasks.Fetch.Request)
}

protocol TodoTasksDataStore {
}

class TodoTasksInteractor: TodoTasksDataStore {
    var presenter: TodoTasksPresentationLogic?
    var taskService: TaskService?

}

extension TodoTasksInteractor: TodoTasksBusinessLogic {
    
    func fetchTodoTasks(request: TodoTasks.Fetch.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }

}

extension TodoTasksInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        let tasks = fetched
            .filter(whereStatusIsTodo)
            .toIdentifiableTasks()
        
        let response = TodoTasks.Fetch.Response(tasks: tasks)
        presenter?.presentTodoTasks(response: response)
    }
    
    func didntFetchTasks(dueToError error: Error) {
        
    }
    
    private func whereStatusIsTodo(_ task: Task) -> Bool {
        if case .todo = task.status {
            return true
        }
        return false
    }

}
