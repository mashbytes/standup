import UIKit

protocol TodoTasksDisplayLogic: class {
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel)
}

class TodoTasksViewController: UIViewController {
    var interactor: TodoTasksBusinessLogic?
    var router: (NSObjectProtocol & TodoTasksRoutingLogic & TodoTasksDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
        
        interactor?.fetchTodoTasks(request: TodoTasks.Fetch.Request())
    }

}

extension TodoTasksViewController: TodoTasksDisplayLogic {
    
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel) {
    }

}
