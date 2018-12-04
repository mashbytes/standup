import UIKit

protocol DashboardRoutingLogic {
}

protocol DashboardDataPassing {
    var dataStore: DashboardDataStore? { get }
}

class DashboardRouter: NSObject, DashboardDataPassing {
    weak var viewController: DashboardViewController?
    var dataStore: DashboardDataStore?

}

extension DashboardRouter: DashboardRoutingLogic {
    
}
