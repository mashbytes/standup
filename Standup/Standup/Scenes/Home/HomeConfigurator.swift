import UIKit


class HomeConfigurator: ControllerConfigurator {

    func configure(_ target: HomeViewController) {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        target.interactor = interactor
        target.router = router
        interactor.presenter = presenter
        presenter.display = target
        router.viewController = target
        router.dataStore = interactor
    }

}

