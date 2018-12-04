import UIKit
import MobileCoreServices

protocol DashboardDisplayLogic: class {
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel)
}

class DashboardViewController: UIViewController {
    var interactor: DashboardBusinessLogic?
    var router: (NSObjectProtocol & DashboardRoutingLogic & DashboardDataPassing)?
    
    @IBOutlet private weak var tableView: UITableView!

    private var sections: [Dashboard.FetchTasks.ViewModel.Section] = []
    private enum ReuseIdentifiers: String {
        case taskRow
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.backgroundColor = .clear
        tableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: ReuseIdentifiers.taskRow.rawValue)
        
        interactor?.fetchTasks(request: Tasks.Fetch.Request())
    }

    private func deleteTask(atIndexPath indexPath: IndexPath) -> Dashboard.FetchTasks.ViewModel.Task {
        let section = sections[indexPath.section]
        var tasks = section.tasks
        let task = tasks.remove(at: indexPath.row)
        let updatedSection = Dashboard.FetchTasks.ViewModel.Section(title: section.title, tasks: tasks)
        sections[indexPath.section] = updatedSection
        return task
    }
    
    private func insertTask(_ task: Dashboard.FetchTasks.ViewModel.Task, atIndexPath indexPath: IndexPath) {
        let section = sections[indexPath.section]
        var tasks = section.tasks
        tasks.insert(task, at: indexPath.row)
        let updatedSection = Dashboard.FetchTasks.ViewModel.Section(title: section.title, tasks: tasks)
        sections[indexPath.section] = updatedSection
    }
    

}

extension DashboardViewController: DashboardDisplayLogic {
    
    func displayTasks(viewModel: Dashboard.FetchTasks.ViewModel) {
        sections = viewModel.sections
        tableView.reloadData()
    }

}

extension DashboardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = deleteTask(atIndexPath: sourceIndexPath)
        insertTask(task, atIndexPath: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let task = sections[indexPath.section].tasks[indexPath.row]
        var actions: [UITableViewRowAction] = []
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            self.interactor?.deleteTask(request: Tasks.Delete.Request(identifier: task.identifier))
        }

        actions.append(delete)
        if !task.isCompleted {
            let complete = UITableViewRowAction(style: .normal, title: "Complete") { _, indexPath in
                self.interactor?.completeTask(request: Tasks.Complete.Request(identifier: task.identifier))
            }
            complete.backgroundColor = .green
            actions.append(complete)
        }
        return actions
    }

}

extension DashboardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifiers.taskRow.rawValue, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let task = sections[indexPath.section].tasks[indexPath.row]
        let model = TaskTableViewCellModel(title: task.title, description: task.description, showTick: task.isCompleted)
        cell.displayModel(model)
        return cell
    }

    
}


extension DashboardViewController: UITableViewDragDelegate {
    // MARK: - UITableViewDragDelegate
    
    /**
     The `tableView(_:itemsForBeginning:at:)` method is the essential method
     to implement for allowing dragging from a table.
     */
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let task = sections[indexPath.section].tasks[indexPath.row]
        let itemProvider = NSItemProvider(object: TaskItemProvider(task: task))
        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }
}


extension DashboardViewController: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: TaskItemProvider.self)
    }
    

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        // The .move operation is available only for dragging within a single app.
        if tableView.hasActiveDrag {
            if session.items.count > 1 {
                return UITableViewDropProposal(operation: .cancel)
            } else {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }
    

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
        let targetIndexPath = destinationIndexPath(fromCoordinator: coordinator, inTableView: tableView)
        
        coordinator.session.loadObjects(ofClass: TaskItemProvider.self) { items in

            // Consume drag items.
            let providers = items as! [TaskItemProvider]
            var indexPaths = [IndexPath]()
            for (index, item) in providers.enumerated() {
                let indexPath = IndexPath(row: targetIndexPath.row + index, section: targetIndexPath.section)
                self.insertTask(item.task, atIndexPath: indexPath)
                indexPaths.append(indexPath)
            }
            
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    private func destinationIndexPath(fromCoordinator coordinator: UITableViewDropCoordinator, inTableView tableView: UITableView) -> IndexPath {
        guard let indexPath = coordinator.destinationIndexPath else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            return IndexPath(row: row, section: section)
        }
        return indexPath
    }
}

private class TaskItemProvider: NSObject, Codable, NSItemProviderReading, NSItemProviderWriting {
    
    let task: Dashboard.FetchTasks.ViewModel.Task
    
    init(task: Dashboard.FetchTasks.ViewModel.Task) {
        self.task = task
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypePlainText as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        return try JSONDecoder().decode(self, from: data)
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypePlainText as String]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(task)
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return nil
    }
    
    
}

