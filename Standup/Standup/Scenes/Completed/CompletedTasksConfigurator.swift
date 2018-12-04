import UIKit


class CompletedTasksConfigurator: ControllerConfigurator {

    func configure(_ target: CompletedTasksViewController) {
        let interactor = CompletedTasksInteractor()
        let presenter = CompletedTasksPresenter()
        let router = CompletedTasksRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}

