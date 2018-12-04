import UIKit


protocol TodoTasksBusinessLogic {
    func doSomething(request: TodoTasks.Something.Request)
}

protocol TodoTasksDataStore {
}

class TodoTasksInteractor: TodoTasksDataStore {
    var presenter: TodoTasksPresentationLogic?

}

extension TodoTasksInteractor: TodoTasksBusinessLogic {
    
    func doSomething(request: TodoTasks.Something.Request) {
        
        let response = TodoTasks.Something.Response(identifier: TodoTasks.Something.DataPassing())
        presenter?.presentSomething(response: response)
    }

}
