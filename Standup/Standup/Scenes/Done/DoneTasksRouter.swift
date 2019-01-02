import UIKit

protocol DoneTasksRoutingLogic {
    
}

protocol DoneTasksDataPassing {
    var dataStore: DoneTasksDataStore? { get }
}

class DoneTasksRouter: NSObject, DoneTasksDataPassing {
    weak var viewController: DoneTasksViewController?
    var dataStore: DoneTasksDataStore?

}

extension DoneTasksRouter: DoneTasksRoutingLogic {
    

}
