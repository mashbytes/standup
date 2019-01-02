import UIKit

protocol DoneTasksDisplayLogic: class {
    func displayDoneTasks(viewModel: DoneTasks.Fetch.ViewModel)
}

class DoneTasksViewController: UIViewController {
    var interactor: DoneTasksBusinessLogic?
    var router: (NSObjectProtocol & DoneTasksRoutingLogic & DoneTasksDataPassing)?

    @IBOutlet private weak var tableView: UITableView!
    private lazy var dataSource: ListTableViewDataSource = {
        return ListTableViewDataSource(listSource: self)
    }()
    private lazy var delegate: ListTableViewDelegate = {
        return ListTableViewDelegate(listDelegate: self)
    }()
    var sections: [Tasks.List.ViewModel.Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Done"

        ListTableViewStyle().styleTableView(tableView)

        tableView.dragInteractionEnabled = true
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(TaskTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchDoneTasks(request: DoneTasks.Fetch.Request())
    }


}

extension DoneTasksViewController: DoneTasksDisplayLogic {
    
    func displayDoneTasks(viewModel: DoneTasks.Fetch.ViewModel) {
        sections = [viewModel.section]
        tableView.reloadData()
    }

}

extension DoneTasksViewController: TodoTasksDisplayLogic {
    
    func displayTodoTasks(viewModel: TodoTasks.Fetch.ViewModel) {
        sections = [viewModel.section]
        tableView.reloadData()
    }
    
}

extension DoneTasksViewController: TaskListDataSource { }

extension DoneTasksViewController: TaskListDelegate {
    
    func performAction(_ action: Tasks.ViewModel.Task.Action, forTask task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath) {
        switch action {
        case .delete:
            let request = MoveTask.ToTrash.Request(identifier: task.identifier)
            interactor?.moveTaskToTrash(request: request)
        case .wip:
            let request = MoveTask.ToToday.Request(identifier: task.identifier, position: .first)
            interactor?.moveTaskToToday(request: request)
        case .todo, .done:
            break
        }
        
    }
    
    
}
