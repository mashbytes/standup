import Foundation
import UIKit
import MobileCoreServices

protocol ListTableDragCoordinatorDelegate: TaskListDataSource { }

class ListTableDragCoordinator: NSObject {
    
    weak var delegate: ListTableDragCoordinatorDelegate?

}

extension ListTableDragCoordinator: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let task = delegate?.taskAtIndexPath(indexPath) else {
            return []
        }
        let itemProvider = NSItemProvider(object: TaskItemProvider(task: task))
        return [
            UIDragItem(itemProvider: itemProvider)
        ]
    }
    
}

extension ListTableDragCoordinator: UITableViewDropDelegate {
    
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
                self.delegate?.insertTask(item.task, atIndexPath: indexPath)
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
