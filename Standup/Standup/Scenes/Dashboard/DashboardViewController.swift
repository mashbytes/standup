import UIKit
import MobileCoreServices

protocol DashboardDisplayLogic: class {
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel)
}

class DashboardViewController: UIViewController {
    var interactor: DashboardBusinessLogic?
    var router: (NSObjectProtocol & DashboardRoutingLogic & DashboardDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!

    private let tableCoordinator = ListTableViewCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dashboard"
        
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
        interactor?.fetchTasks(request: Dashboard.FetchTasks.Request())
    }
    

}

extension DashboardViewController: DashboardDisplayLogic {
    
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel) {
        tableCoordinator.sections = viewModel.sections
        tableView.reloadData()
    }
    
}

extension DashboardViewController: ListTableViewCoordinatorDelegate {
    
    func task(_ task: Tasks.ViewModel.Task, insertedInSection section: Tasks.List.ViewModel.Section) {
        
    }
    
    func task(_ task: Tasks.ViewModel.Task, deletedFromSection section: Tasks.List.ViewModel.Section) {
        
    }
    
    func task(_ task: Tasks.ViewModel.Task, movedFrom from: IndexPath, to: IndexPath) {
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
        let tasks = tableCoordinator.sections[indexPath.section].tasks
        if indexPath.row == tasks.count - 1 {
            return .last
        }
        let before = tasks[indexPath.row - 1]
        let after = tasks[indexPath.row + 1]
        return .between(before.identifier, after.identifier)
        
    }
}

