import Foundation
import UIKit

enum TaskAction {
    case move(IndexPath, IndexPath)
//    case insert(Tasks.ViewModel.Task)
    case delete(IndexPath)
    case complete(IndexPath)
}

protocol SupportsTaskActions {
    
//    func moveTask(from: IndexPath, to: IndexPath)
//    func insertTask(_ task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath)
//    func deleteTask(atIndexPath indexPath: IndexPath) -> Tasks.ViewModel.Task
    func taskAtIndexPath(_ indexPath: IndexPath) -> Tasks.ViewModel.Task
    
    func performAction(_ action: TaskAction)
}

//extension SupportsTaskActions {
//
//    func moveTask(from: IndexPath, to: IndexPath) {
//        let task = deleteTask(atIndexPath: from)
//        insertTask(task, atIndexPath: to)
//    }
//}


extension SupportsTaskActions where Self: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        performAction(.move(sourceIndexPath, destinationIndexPath))
//        moveTask(from: sourceIndexPath, to: destinationIndexPath)
//        let task = deleteTask(atIndexPath: sourceIndexPath)
//        insertTask(task, atIndexPath: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let task = taskAtIndexPath(indexPath)
        var actions: [UITableViewRowAction] = []
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            self.performAction(.delete(indexPath))
        }
        
        actions.append(delete)
        if !task.isCompleted {
            let complete = UITableViewRowAction(style: .normal, title: "Complete") { _, indexPath in
                self.performAction(.complete(indexPath))
            }
            complete.backgroundColor = .green
            actions.append(complete)
        }
        return actions
    }

}
