import UIKit


class TodoTasksConfigurator: ControllerConfigurator {

    func configure(_ target: TodoTasksViewController) {
        let interactor = TodoTasksInteractor()
        let presenter = TodoTasksPresenter()
        let router = TodoTasksRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        interactor.taskService = InMemoryTaskService(initial: [FakeTasks.todo(), FakeTasks.todo()])
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}

