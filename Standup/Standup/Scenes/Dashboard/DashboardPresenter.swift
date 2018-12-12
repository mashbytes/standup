import UIKit

protocol DashboardPresentationLogic {
    func presentTasks(response: Dashboard.FetchTasks.Response)
}

class DashboardPresenter {
    weak var display: DashboardDisplayLogic?
  
}

extension DashboardPresenter: DashboardPresentationLogic {
    
    func presentTasks(response: Dashboard.FetchTasks.Response) {
        let todayVMs = response.today.map(buildTaskViewModel)
        let todaySection = Dashboard.FetchTasks.ViewModel.Section(title: "Today", tasks: todayVMs)
        let yesterdayVMs = response.yesterday.map(buildTaskViewModel)
        let yesterdaySection = Dashboard.FetchTasks.ViewModel.Section(title: "Todo", tasks: yesterdayVMs)
        let viewModel = Dashboard.FetchTasks.ViewModel(sections: [todaySection, yesterdaySection])
        display?.displayTasks(viewModel: viewModel)
    }
    
    private func buildTaskViewModel(fromTask task: Dashboard.FetchTasks.Response.IdentifiableTask) -> Dashboard.FetchTasks.ViewModel.Task {
        let created = task.task.createdDate.description
        let completed = task.task.completedDate?.description
        return Dashboard.FetchTasks.ViewModel.Task(identifier: task.identifier, title: task.task.title, description: task.task.description, createdDate: created, completedDate: completed, actions: [])
    }

}
