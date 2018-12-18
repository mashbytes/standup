import UIKit

protocol DashboardPresentationLogic {
    func presentTasks(response: Dashboard.FetchTasks.Response)
}

class DashboardPresenter {
    weak var display: DashboardDisplayLogic?
  
}

extension DashboardPresenter: DashboardPresentationLogic {
    
    func presentTasks(response: Dashboard.FetchTasks.Response) {
        let todayVMs = response.today.toViewModels()
        let todaySection = Dashboard.FetchTasks.ViewModel.Section(title: "Today", tasks: todayVMs)
        let yesterdayVMs = response.yesterday.toViewModels()
        let yesterdaySection = Dashboard.FetchTasks.ViewModel.Section(title: "Todo", tasks: yesterdayVMs)
        let viewModel = Dashboard.FetchTasks.ViewModel(sections: [yesterdaySection, todaySection])
        display?.displayTasks(viewModel: viewModel)
    }
    
}
