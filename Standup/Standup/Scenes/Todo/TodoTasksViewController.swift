import UIKit

protocol TodoTasksDisplayLogic: class {
    func displaySomething(viewModel: TodoTasks.Something.ViewModel)
}

class TodoTasksViewController: UIViewController {
    var interactor: TodoTasksBusinessLogic?
    var router: (NSObjectProtocol & TodoTasksRoutingLogic & TodoTasksDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = TodoTasks.Something.Request()
        interactor?.doSomething(request: request)
    }

}

extension TodoTasksViewController: TodoTasksDisplayLogic {
    
    func displaySomething(viewModel: TodoTasks.Something.ViewModel) {
    }

}
