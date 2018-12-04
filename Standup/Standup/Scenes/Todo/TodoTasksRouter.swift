import UIKit

protocol TodoTasksRoutingLogic {

}

protocol TodoTasksDataPassing {
    var dataStore: TodoTasksDataStore? { get }
}

class TodoTasksRouter: NSObject, TodoTasksDataPassing {
    weak var viewController: TodoTasksViewController?
    var dataStore: TodoTasksDataStore?

}

extension TodoTasksRouter: TodoTasksRoutingLogic {

    
}
