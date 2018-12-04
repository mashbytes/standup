import UIKit


class DashboardConfigurator: ControllerConfigurator {

    func configure(_ target: DashboardViewController) {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        let router = DashboardRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        interactor.taskService = InMemoryTaskService(initial: dummyTasks)
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}

private let dummyTasks = [
    Task(id: "1", title: "task 1", description: nil, createdDate: Date(), scheduledDate: Date(), completedDate: nil),
    Task(id: "2", title: "task 2", description: nil, createdDate: Date(), scheduledDate: Date(), completedDate: Date()),
    Task(id: "3", title: "task 3", description: nil, createdDate: Date(), scheduledDate: Date(), completedDate: nil),
    Task(id: "4", title: "task 4", description: nil, createdDate: Date(), scheduledDate: Date(), completedDate: Date()),
    
]
