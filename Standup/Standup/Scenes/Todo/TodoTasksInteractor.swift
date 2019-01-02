import UIKit


protocol TodoTasksBusinessLogic: MoveTaskToTodayBusinessLogic, MoveTaskToDoneBusinessLogic, MoveTaskToYesterdayBusinessLogic, MoveTaskToTrashBusinessLogic {
    
    func fetchTodoTasks(request: TodoTasks.Fetch.Request)
}

protocol TodoTasksDataStore: TaskDataStore { }

class TodoTasksInteractor: TodoTasksDataStore, KeyedTasksDataStore, FiltersTodoTasks {
    
    var presenter: TodoTasksPresentationLogic?
    var taskService: TaskService?
    lazy var taskReorderer: TaskReorderer? = {
        return DefaultTaskReorderer(dataStore: self)
    }()
    var keyedTasks: [Task.ID: Task] = [:] {
        didSet {
            displayTasks()
        }
    }
    
    func displayTasks() {
        let todo = todoTasks(from: tasks)
        let response = TodoTasks.Fetch.Response(tasks: todo.toIdentifiableTasks())
        presenter?.presentTodoTasks(response: response)
    }

}

extension TodoTasksInteractor: TodoTasksBusinessLogic {
    
    func fetchTodoTasks(request: TodoTasks.Fetch.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }

}

extension TodoTasksInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        keyedTasks = fetched.toKeyedDictionary()
    }
    
    func didntFetchTasks(dueToError error: Error) {
        // TODO
    }

}

extension TodoTasksInteractor: DefaultMoveTaskToTodayBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTodayDueTo error: Error) {
        
    }

}

extension TodoTasksInteractor: DefaultMoveTaskToYesterdayBusinessLogic {
    
    func didntMoveTask(_ task: Task, toYesterdayDueTo error: Error) {
        
    }
    
}

extension TodoTasksInteractor: DefaultMoveTaskToDoneBusinessLogic {
    
    func didntMoveTask(_ task: Task, toDoneDueTo error: Error) {
        
    }
    
}

extension TodoTasksInteractor: DefaultMoveTaskToTrashBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTrashDueTo error: Error) {
        
    }
    
}
