import UIKit

protocol CompletedTasksRoutingLogic {
    func routeToSomewhere(identifier: CompletedTasks.Something.DataPassing)
}

protocol CompletedTasksDataPassing {
    var dataStore: CompletedTasksDataStore? { get }
}

class CompletedTasksRouter: NSObject, CompletedTasksDataPassing {
    weak var viewController: CompletedTasksViewController?
    var dataStore: CompletedTasksDataStore?

}

extension CompletedTasksRouter: CompletedTasksRoutingLogic {
    
    func routeToSomewhere(identifier: CompletedTasks.Something.DataPassing) {
        
    }

}
