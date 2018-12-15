import UIKit

protocol TodoTasksPresentationLogic {
    func presentTodoTasks(response: TodoTasks.Fetch.Response)
}

class TodoTasksPresenter {
    weak var display: TodoTasksDisplayLogic?
  
}

extension TodoTasksPresenter: TodoTasksPresentationLogic {
    
    func presentTodoTasks(response: TodoTasks.Fetch.Response) {
        let vms = response.tasks.toViewModels()
        
        let section = Tasks.List.ViewModel.Section(title: "Todo", tasks: vms)
        let viewModel = TodoTasks.Fetch.ViewModel(section: section)
        display?.displayTodoTasks(viewModel: viewModel)
    }

}


