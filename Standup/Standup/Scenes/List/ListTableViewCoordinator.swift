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
    
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //
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

extension ListTableViewCoordinator: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let task = sections[indexPath.section].tasks[indexPath.row]
        let itemProvider = NSItemProvider(object: TaskItemProvider(task: task))
        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }

}

extension ListTableViewCoordinator: UITableViewDropDelegate {
    
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
    
    let task: Tasks.ViewModel.Task
    
    init(task: Tasks.ViewModel.Task) {
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

