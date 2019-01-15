import UIKit


class DashboardConfigurator: ControllerConfigurator {

    func configure(_ target: DashboardViewController) {
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        let router = DashboardRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        interactor.taskService = ServiceLocator.shared.taskService()
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}

