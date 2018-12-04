import UIKit

protocol CompletedTasksDisplayLogic: class {
    func displaySomething(viewModel: CompletedTasks.Something.ViewModel)
}

class CompletedTasksViewController: UIViewController {
    var interactor: CompletedTasksBusinessLogic?
    var router: (NSObjectProtocol & CompletedTasksRoutingLogic & CompletedTasksDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Completed"
        let request = CompletedTasks.Something.Request()
        interactor?.doSomething(request: request)
    }

}

extension CompletedTasksViewController: CompletedTasksDisplayLogic {
    
    func displaySomething(viewModel: CompletedTasks.Something.ViewModel) {
    }

}
