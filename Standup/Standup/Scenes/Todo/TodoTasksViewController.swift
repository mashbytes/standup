import UIKit

protocol TodoTasksDisplayLogic: class {
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel)
}

class TodoTasksViewController: UIViewController {
    var interactor: TodoTasksBusinessLogic?
    var router: (NSObjectProtocol & TodoTasksRoutingLogic & TodoTasksDataPassing)?

    @IBOutlet private weak var tableView: UITableView!
    private let dragCoordinator = ListTableDragCoordinator()
    private lazy var dataSource: ListTableViewDataSource = {
        return ListTableViewDataSource(listSource: self)
    }()
    private lazy var delegate: ListTableViewDelegate = {
        return ListTableViewDelegate(listDelegate: self)
    }()
    var sections: [Tasks.List.ViewModel.Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
        
        ListTableViewStyle().styleTableView(tableView)
        
        dragCoordinator.delegate = self
        tableView.dragInteractionEnabled = true
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.dragDelegate = dragCoordinator
        tableView.dropDelegate = dragCoordinator
        tableView.register(TaskTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTodoTasks(request: TodoTasks.Fetch.Request())
    }

}

extension TodoTasksViewController: ListTableDragCoordinatorDelegate {
    
}

extension TodoTasksViewController: TodoTasksDisplayLogic {
    
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel) {
        sections = [viewModel.section]
        tableView.reloadData()
    }

}

extension TodoTasksViewController: TaskListDataSource { }

extension TodoTasksViewController: TaskListDelegate {
    func performAction(_ action: Tasks.ViewModel.Task.Action, forTask task: Tasks.ViewModel.Task) {
        
    }
    
    
}
