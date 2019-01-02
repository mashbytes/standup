import UIKit


class DoneTasksConfigurator: ControllerConfigurator {

    func configure(_ target: DoneTasksViewController) {
        let interactor = DoneTasksInteractor()
        let presenter = DoneTasksPresenter()
        let router = DoneTasksRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        interactor.taskService = InMemoryTaskService.shared
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}

