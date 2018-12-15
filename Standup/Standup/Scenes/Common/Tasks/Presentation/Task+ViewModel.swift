import Foundation

extension Task {
    
    func toViewModel(withIdentifier identifier: Tasks.DataPassing.TaskIdentifier) -> Tasks.ViewModel.Task {
        return Tasks.ViewModel.Task(identifier: identifier, title: title, completedDate: completed, actions: actions)
    }
    
    var actions: [Tasks.ViewModel.Task.Action] {
        switch self.status {
        case .done: return [.delete, .markIncomplete]
        case .wip: return [.delete, .markComplete]
        case .todo: return [.delete, .start]
        }
    }
    
    var completed: String? {
        switch self.status {
        case .done(let date): return date.description
        default: return nil
        }
    }
}

extension Array where Element == (Tasks.DataPassing.TaskIdentifier, Task) {
    
    func toViewModels() -> [Tasks.ViewModel.Task] {
        return self
            .sorted { t1, t2 in return t1.1.order < t2.1.order }
            .map { (id, task) in
                return task.toViewModel(withIdentifier: id)
        }
    }
}
