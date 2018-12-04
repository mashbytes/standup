import UIKit

protocol CompletedTasksPresentationLogic {
    func presentSomething(response: CompletedTasks.Something.Response)
}

class CompletedTasksPresenter {
    weak var display: CompletedTasksDisplayLogic?
  
}

extension CompletedTasksPresenter: CompletedTasksPresentationLogic {
    
    func presentSomething(response: CompletedTasks.Something.Response) {
        let viewModel = CompletedTasks.Something.ViewModel(identifier: response.identifier)
        display?.displaySomething(viewModel: viewModel)
    }

}
