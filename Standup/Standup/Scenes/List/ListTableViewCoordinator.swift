import Foundation
import UIKit
import MobileCoreServices

protocol ListTableViewCoordinatorDelegate: class {
    
    func task(_ task: Tasks.ViewModel.Task, deletedFromSection section: Tasks.List.ViewModel.Section)
    func task(_ task: Tasks.ViewModel.Task, insertedInSection section: Tasks.List.ViewModel.Section)
    func task(_ task: Tasks.ViewModel.Task, movedFrom from: IndexPath, to: IndexPath)
    
}

class ListTableViewCoordinator: NSObject {
    
    var sections: [Tasks.List.ViewModel.Section] = []
    weak var delegate: ListTableViewCoordinatorDelegate?
    
    func prepare(tableView: UITableView) {
        tableView.register(TaskTableViewCell.self)
    }

    private func deleteTask(atIndexPath indexPath: IndexPath) -> Tasks.ViewModel.Task {
        let section = sections[indexPath.section]
        var tasks = section.tasks
        let task = tasks.remove(at: indexPath.row)
        let updatedSection = Tasks.List.ViewModel.Section(title: section.title, tasks: tasks)
        sections[indexPath.section] = updatedSection
        delegate?.task(task, deletedFromSection: section)
        return task
    }
    
    private func insertTask(_ task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath) {
        let section = sections[indexPath.section]
        var tasks = section.tasks
        tasks.insert(task, at: indexPath.row)
        let updatedSection = Tasks.List.ViewModel.Section(title: section.title, tasks: tasks)
        sections[indexPath.section] = updatedSection
        delegate?.task(task, insertedInSection: updatedSection)
    }
    

}

extension ListTableViewCoordinator: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let section = sections[indexPath.section]
        let task = section.tasks[indexPath.row]
        return task.actions.map { action in
            switch action {
            case .delete: return UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
                    self.delegate?.task(task, deletedFromSection: section)
                }
            case .markComplete: return UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
                self.delegate?.task(task, deletedFromSection: section)
                }
            case .markIncomplete: return UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
                self.delegate?.task(task, deletedFromSection: section)
                }
            case .start: return UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
                self.delegate?.task(task, deletedFromSection: section)
                }
            }
        }
    }
    
}

extension ListTableViewCoordinator: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(forIndexPath: indexPath) as TaskTableViewCell
        let task = sections[indexPath.section].tasks[indexPath.row]
        let model = TaskTableViewCellModel(title: task.title, showTick: task.isCompleted)
        cell.displayModel(model)
        return cell
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = deleteTask(atIndexPath: sourceIndexPath)
        insertTask(task, atIndexPath: destinationIndexPath)
        delegate?.task(task, movedFrom: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}


