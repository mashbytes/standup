import UIKit


protocol CompletedTasksBusinessLogic {
    func doSomething(request: CompletedTasks.Something.Request)
}

protocol CompletedTasksDataStore {
}

class CompletedTasksInteractor: CompletedTasksDataStore {
    var presenter: CompletedTasksPresentationLogic?

}

extension CompletedTasksInteractor: CompletedTasksBusinessLogic {
    
    func doSomething(request: CompletedTasks.Something.Request) {
        
        let response = CompletedTasks.Something.Response(identifier: CompletedTasks.Something.DataPassing())
        presenter?.presentSomething(response: response)
    }

}
