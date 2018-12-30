import Foundation

protocol TaskListDelegate: class {
    
    var sections: [Tasks.List.ViewModel.Section] { get set }

    func performAction(_ action: Tasks.ViewModel.Task.Action, forTask task: Tasks.ViewModel.Task)
    func taskAtIndexPath(_ indexPath: IndexPath) -> Tasks.ViewModel.Task
    
}

//extension TaskListDelegate {
//    
//    func taskAtIndexPath(_ indexPath: IndexPath) -> Tasks.ViewModel.Task {
//        return sections[indexPath.section].tasks[indexPath.row]
//    }
//}
