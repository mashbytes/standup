import UIKit


protocol TodoTasksBusinessLogic: TaskBusinessLogic {
    func fetchTodoTasks(request: TodoTasks.Fetch.Request)
}

protocol TodoTasksDataStore: TaskDataStore {
}

class TodoTasksInteractor: TodoTasksDataStore {
    var presenter: TodoTasksPresentationLogic?
    var taskService: TaskService?
    lazy var taskReorderer: TaskReorderer = {
        return DefaultTaskReorderer(dataStore: self)
    }()
    var keyedTasks: [Task.ID: Task] = [:]
}

extension TodoTasksInteractor: TodoTasksBusinessLogic {
    
    func fetchTodoTasks(request: TodoTasks.Fetch.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }

}

extension TodoTasksInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        keyedTasks = fetched.toKeyedDictionary()
        displayTasks()
    }
    
    func didntFetchTasks(dueToError error: Error) {
        // TODO
    }

}

extension TodoTasksInteractor: DefaultTaskBusinessLogic {
    
    func displayTasks() {
        let response = TodoTasks.Fetch.Response(tasks: todo.toIdentifiableTasks())
        presenter?.presentTodoTasks(response: response)
    }

}

