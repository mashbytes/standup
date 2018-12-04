import UIKit

protocol TodoTasksPresentationLogic {
    func presentSomething(response: TodoTasks.Something.Response)
}

class TodoTasksPresenter {
    weak var display: TodoTasksDisplayLogic?
  
}

extension TodoTasksPresenter: TodoTasksPresentationLogic {
    
    func presentSomething(response: TodoTasks.Something.Response) {
        let viewModel = TodoTasks.Something.ViewModel(identifier: response.identifier)
        display?.displaySomething(viewModel: viewModel)
    }

}
