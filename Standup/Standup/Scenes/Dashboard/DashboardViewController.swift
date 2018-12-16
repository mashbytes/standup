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

extension DashboardViewController: ListTableViewCoordinatorDelegate {
    
    func task(_ task: Tasks.ViewModel.Task, insertedInSection section: Tasks.List.ViewModel.Section) {
        
    }
    
    func task(_ task: Tasks.ViewModel.Task, deletedFromSection section: Tasks.List.ViewModel.Section) {
        
    }
}

extension DashboardViewController: DashboardDisplayLogic {
    
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel) {
        tableCoordinator.sections = viewModel.sections
        tableView.reloadData()
    }

}
