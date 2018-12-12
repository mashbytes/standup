import UIKit

protocol TodoTasksDisplayLogic: class {
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel)
}

class TodoTasksViewController: UIViewController {
    var interactor: TodoTasksBusinessLogic?
    var router: (NSObjectProtocol & TodoTasksRoutingLogic & TodoTasksDataPassing)?

    @IBOutlet private weak var tableView: UITableView!
    private let tableCoordinator = ListTableViewCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
    
        tableCoordinator.delegate = self
        
        ListTableViewStyle().styleTableView(tableView)

        tableView.dragInteractionEnabled = true
        tableView.delegate = tableCoordinator
        tableView.dataSource = tableCoordinator
        tableView.dragDelegate = tableCoordinator
        tableView.dropDelegate = tableCoordinator
        tableCoordinator.prepare(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTodoTasks(request: TodoTasks.Fetch.Request())
    }

}

extension TodoTasksViewController: ListTableViewCoordinatorDelegate {
    
    func task(_ task: Tasks.ViewModel.Task, insertedInSection section: Tasks.List.ViewModel.Section) {
        
    }
    
    func task(_ task: Tasks.ViewModel.Task, deletedFromSection section: Tasks.List.ViewModel.Section) {
        
    }
}

extension TodoTasksViewController: TodoTasksDisplayLogic {
    
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel) {
        tableCoordinator.sections = viewModel.sections
        tableView.reloadData()
    }

}
