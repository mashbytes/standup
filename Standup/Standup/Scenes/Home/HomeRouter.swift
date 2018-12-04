import UIKit

protocol HomeRoutingLogic {
    func routeToSomewhere(identifier: Home.Something.DataPassing)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

}

extension HomeRouter: HomeRoutingLogic {
    
    func routeToSomewhere(identifier: Home.Something.DataPassing) {
        
    }

}
