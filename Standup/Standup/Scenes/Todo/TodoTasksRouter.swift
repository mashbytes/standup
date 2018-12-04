import UIKit

protocol TodoTasksRoutingLogic {
    func routeToSomewhere(identifier: TodoTasks.Something.DataPassing)
}

protocol TodoTasksDataPassing {
    var dataStore: TodoTasksDataStore? { get }
}

class TodoTasksRouter: NSObject, TodoTasksDataPassing {
    weak var viewController: TodoTasksViewController?
    var dataStore: TodoTasksDataStore?

}

extension TodoTasksRouter: TodoTasksRoutingLogic {
    
    func routeToSomewhere(identifier: TodoTasks.Something.DataPassing) {
        
    }

}
