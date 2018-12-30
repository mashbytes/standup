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

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTasks(request: Dashboard.FetchTasks.Request())
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
            let request = Dashboard.MoveTaskToYesterday.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToYesterday(request: request)
        case 1:
            let position = targetPosition(fromIndexPath: to)
            let request = Dashboard.MoveTaskToToday.Request(identifier: task.identifier, position: position)
            interactor?.moveTaskToToday(request: request)
        default:
            return
        }
    }
    
    private func targetPosition(fromIndexPath indexPath: IndexPath) -> Dashboard.MoveTaskRequest.Position {
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
    
    func performAction(_ action: Tasks.ViewModel.Task.Action, forTask task: Tasks.ViewModel.Task) {
        switch action {
        case .delete:
            interactor?.deleteTask(request: Dashboard.DeleteTask.Request(identifier: task.identifier))
        case .markComplete:
            interactor?.markTaskAsDone(request: Dashboard.MarkTaskAsDone.Request(identifier: task.identifier))
        case .markIncomplete:
            interactor?.markTaskAsTodo(request: Dashboard.MarkTaskAsTodo.Request(identifier: task.identifier))
        case .start: break
        }
    }

}


