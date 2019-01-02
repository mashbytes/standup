import Foundation

protocol TaskViewModelTransformer {
    
    func transform(task: Tasks.IdentifiableTask) -> Tasks.ViewModel.Task?
    
}

class DefaultTaskViewModelTransformer: TaskViewModelTransformer {
    
    func transform(task: Tasks.IdentifiableTask) -> Tasks.ViewModel.Task? {
        let identifier = task.0
        let title = task.1.title
        let completed = completedForTask(task.1)
        let actions = actionsForTask(task.1)
        return Tasks.ViewModel.Task(identifier: identifier, title: title, completedDate: completed, actions: actions)
    }

    func actionsForTask(_ task: Task) -> [Tasks.ViewModel.Task.Action] {
        switch task.status {
        case .done: return [.todo, .wip, .delete]
        case .wip: return [.done, .todo, .delete]
        case .todo: return [.wip, .delete]
        }
    }
    
    func completedForTask(_ task: Task) -> String? {
        switch task.status {
        case .done(let date): return date.description
        default: return nil
        }
    }

}

extension Array where Element == Tasks.IdentifiableTask {
    
    func toViewModels(usingTransformer transformer: TaskViewModelTransformer = DefaultTaskViewModelTransformer()) -> [Tasks.ViewModel.Task] {
        return self
            .sorted { t1, t2 in return t1.1.order < t2.1.order }
            .compactMap { return transformer.transform(task: $0) }
    }
}
