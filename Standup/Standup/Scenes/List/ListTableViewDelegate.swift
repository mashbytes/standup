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
                self.delegate?.performAction(.delete, forTask: task)
                }
            case .markComplete: return UITableViewRowAction(style: .destructive, title: "Done") { _, _ in
                self.delegate?.performAction(.markComplete, forTask: task)
                }
            case .markIncomplete: return UITableViewRowAction(style: .destructive, title: "Todo") { _, _ in
                self.delegate?.performAction(.markIncomplete, forTask: task)
                }
            case .start: return UITableViewRowAction(style: .destructive, title: "Start") { _, _ in
                self.delegate?.performAction(.start, forTask: task)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
