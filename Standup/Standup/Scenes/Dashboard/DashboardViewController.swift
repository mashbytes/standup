import UIKit
import MobileCoreServices

protocol DashboardDisplayLogic: class {
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel)
}

class DashboardViewController: UIViewController {
    var interactor: DashboardBusinessLogic?
    var router: (NSObjectProtocol & DashboardRoutingLogic & DashboardDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!

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
        
        title = "Dashboard"
        
        ListTableViewStyle().styleTableView(tableView)

        dragCoordinator.delegate = self
        tableView.dragInteractionEnabled = true
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.dragDelegate = dragCoordinator
        tableView.dropDelegate = dragCoordinator
        tableView.register(TaskTableViewCell.self)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.setRightBarButton(addButton, animated: true)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTasks(request: Dashboard.FetchTasks.Request())
    }

    @objc
    private func addButtonTapped() {
        router?.routeToAddTask()
    }
}

extension DashboardViewController: DashboardDisplayLogic {
    
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel) {
        sections = viewModel.sections
        tableView.reloadData()
    }
    
}

extension DashboardViewController: ListTableDragCoordinatorDelegate { }

extension DashboardViewController: TaskListDataSource {

    func didMoveTask(_ task: Tasks.ViewModel.Task, from: IndexPath, to: IndexPath) {
        // todo don't like this being magic number based
        switch to.section {
        case 0:
            let position = targetPosition(fromIndexPath: to)
            let request = MoveTask.ToYesterday.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToYesterday(request: request)
        case 1:
            let position = targetPosition(fromIndexPath: to)
            let request = MoveTask.ToToday.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToToday(request: request)
        default:
            return
        }
    }
    
    private func targetPosition(fromIndexPath indexPath: IndexPath) -> MoveTask.Position {
        if indexPath.row == 0 {
            return .first
        }
        let tasks = sections[indexPath.section].tasks
        if indexPath.row == tasks.count - 1 {
            return .last
        }
        let before = tasks[indexPath.row - 1]
        let after = tasks[indexPath.row + 1]
        return .between(before.identifier, after.identifier)
        
    }

}

extension DashboardViewController: TaskListDelegate {
    
    func performAction(_ action: Tasks.ViewModel.Task.Action, forTask task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath) {
        switch action {
        case .delete:
            let request = MoveTask.ToTrash.Request(identifier: task.identifier)
            interactor?.moveTaskToTrash(request: request)
        case .done:
            let position = targetPosition(fromIndexPath: indexPath)
            let request = MoveTask.ToDone.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToDone(request: request)
        case .todo:
            let position = targetPosition(fromIndexPath: indexPath)
            let request = MoveTask.ToTodo.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToTodo(request: request)
        case .wip:
            let position = targetPosition(fromIndexPath: indexPath)
            let request = MoveTask.ToToday.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToToday(request: request)
            break
        }
    }

}

