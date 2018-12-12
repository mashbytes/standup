import UIKit


class TodoTasksConfigurator: ControllerConfigurator {

    func configure(_ target: TodoTasksViewController) {
        let interactor = TodoTasksInteractor()
        let presenter = TodoTasksPresenter()
        let router = TodoTasksRouter()
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
    Task(id: "100", title: "task 100", description: nil, createdDate: Date(), scheduledDate: Date(), completedDate: nil),
    Task(id: "101", title: "task 101", description: nil, createdDate: Date(), scheduledDate: nil, completedDate: nil),
    Task(id: "102", title: "task 102", description: nil, createdDate: Date(), scheduledDate: nil, completedDate: Date()),
    Task(id: "103", title: "task 103", description: nil, createdDate: Date(), scheduledDate: nil, completedDate: nil),
    
]
