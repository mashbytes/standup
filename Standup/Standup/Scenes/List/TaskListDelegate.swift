import Foundation

protocol TaskListDelegate: class {
    
    var sections: [Tasks.List.ViewModel.Section] { get set }

    func performAction(_ action: Tasks.ViewModel.Task.Action, forTask task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath)
    func taskAtIndexPath(_ indexPath: IndexPath) -> Tasks.ViewModel.Task
    
}

extension TaskListDelegate {
    
    func targetPosition(fromIndexPath indexPath: IndexPath) -> MoveTask.Position {
        if indexPath.row == 0 {
            return .first
        }
        let tasks = sections[indexPath.section].tasks
        if indexPath.row == tasks.count - 1 {
            return .last
        }
        let before = tasks[indexPath.row - 1]
        let after = tasks[indexPath.row + 1]
        return .between(before.identifier, after.identifier)
        
    }

}
