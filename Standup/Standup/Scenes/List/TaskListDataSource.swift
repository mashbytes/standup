import Foundation

protocol TaskListDataSource: class {
    
    var sections: [Tasks.List.ViewModel.Section] { get set }
    
    func deleteTask(atIndexPath indexPath: IndexPath) -> Tasks.ViewModel.Task
    func insertTask(_ task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath)
    func moveTask(from: IndexPath, to: IndexPath)
    func taskAtIndexPath(_ indexPath: IndexPath) -> Tasks.ViewModel.Task
    func didMoveTask(_ task: Tasks.ViewModel.Task, from: IndexPath, to: IndexPath)
}

extension TaskListDataSource {
    
    func deleteTask(atIndexPath indexPath: IndexPath) -> Tasks.ViewModel.Task {
        let section = sections[indexPath.section]
        var tasks = section.tasks
        let task = tasks.remove(at: indexPath.row)
        let updatedSection = Tasks.List.ViewModel.Section(title: section.title, tasks: tasks)
        sections[indexPath.section] = updatedSection
        return task
    }
    
    func insertTask(_ task: Tasks.ViewModel.Task, atIndexPath indexPath: IndexPath) {
        let section = sections[indexPath.section]
        var tasks = section.tasks
        tasks.insert(task, at: indexPath.row)
        let updatedSection = Tasks.List.ViewModel.Section(title: section.title, tasks: tasks)
        sections[indexPath.section] = updatedSection
    }
    
    func taskAtIndexPath(_ indexPath: IndexPath) -> Tasks.ViewModel.Task {
        return sections[indexPath.section].tasks[indexPath.row]
    }

    func moveTask(from: IndexPath, to: IndexPath) {
        let moving = deleteTask(atIndexPath: from)
        insertTask(moving, atIndexPath: to)
        didMoveTask(moving, from: from, to: to)
    }
    
    func didMoveTask(_ task: Tasks.ViewModel.Task, from: IndexPath, to: IndexPath) {
    }

}

