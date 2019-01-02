import Foundation
import UIKit

class ListTableViewDelegate: NSObject, UITableViewDelegate {
    
    private weak var delegate: TaskListDelegate?
    
    init(listDelegate: TaskListDelegate) {
        delegate = listDelegate
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let task = delegate?.taskAtIndexPath(indexPath) else {
            return nil
        }
        return task.actions.map { action in
            switch action {
            case .delete: return UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
                self.delegate?.performAction(.delete, forTask: task, atIndexPath: indexPath)
                }
            case .done: return UITableViewRowAction(style: .normal, title: "Done") { _, _ in
                self.delegate?.performAction(.done, forTask: task, atIndexPath: indexPath)
                }
            case .todo: return UITableViewRowAction(style: .normal, title: "Todo") { _, _ in
                self.delegate?.performAction(.todo, forTask: task, atIndexPath: indexPath)
                }
            case .wip: return UITableViewRowAction(style: .normal, title: "WIP") { _, _ in
                self.delegate?.performAction(.wip, forTask: task, atIndexPath: indexPath)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
