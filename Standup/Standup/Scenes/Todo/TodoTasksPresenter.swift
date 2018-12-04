import UIKit

protocol TodoTasksPresentationLogic {
    func presentTodoTasks(response: TodoTasks.Fetch.Response)
}

class TodoTasksPresenter {
    weak var display: TodoTasksDisplayLogic?
  
}

extension TodoTasksPresenter: TodoTasksPresentationLogic {
    
    func presentTodoTasks(response: TodoTasks.Fetch.Response) {
        let sections = response.sections.map { section -> TodoTasks.Fetch.ViewModel.Section in
            let identifier = section.identifier
            let title = section.title
            let tasks = section.tasksVMs
            return TodoTasks.Fetch.ViewModel.Section(identifier: identifier, title: title, tasks: tasks)
        }
        let viewModel = TodoTasks.Fetch.ViewModel(sections: sections)
        display?.displayTodoTasks(viewModel: viewModel)
    }

}

private extension TodoTasks.Fetch.Response.Section {
    
    var title: String {
        guard let date = date else {
            return "Unscheduled"
        }
        return date.description
    }
    
    var tasksVMs: [Tasks.ViewModel.Task] {
        return tasks.map { pair in
            let (identifier, task) = pair
            return Tasks.ViewModel.Task(identifier: identifier, title: task.title, description: task.description, createdDate: task.createdDate.description, completedDate: task.completedDate?.description)
        }
    }
}
