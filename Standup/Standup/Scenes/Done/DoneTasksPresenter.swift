import UIKit

protocol DoneTasksPresentationLogic {
    func presentDoneTasks(response: DoneTasks.Fetch.Response)
}

class DoneTasksPresenter {
    weak var display: DoneTasksDisplayLogic?
  
}

extension DoneTasksPresenter: DoneTasksPresentationLogic {
    
    func presentDoneTasks(response: DoneTasks.Fetch.Response) {
        let vms = response.tasks
            .toViewModels(usingTransformer: DoneTaskViewModelTransformer())
        
        let section = Tasks.List.ViewModel.Section(title: "Todo", tasks: vms)
        let viewModel = DoneTasks.Fetch.ViewModel(section: section)
        display?.displayDoneTasks(viewModel: viewModel)
    }

}

class DoneTaskViewModelTransformer: DefaultTaskViewModelTransformer {
    
    override func actionsForTask(_ task: Task) -> [Tasks.ViewModel.Task.Action] {
        switch task.status {
        case .done: return [.wip, .delete]
        default: return [.delete]
        }
    }
}
