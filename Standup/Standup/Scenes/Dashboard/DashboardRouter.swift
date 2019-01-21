import UIKit

protocol DashboardRoutingLogic {
    func routeToAddTask()
}

protocol DashboardDataPassing {
    var dataStore: DashboardDataStore? { get }
}

class DashboardRouter: NSObject, DashboardDataPassing {
    weak var viewController: DashboardViewController?
    var dataStore: DashboardDataStore?

}

extension DashboardRouter: DashboardRoutingLogic {
    
    func routeToAddTask() {
        let alert = UIAlertController(title: "Add task", message: nil, preferredStyle: .alert)
        alert.addTextField { tf in
            tf.placeholder = "Title"
        }
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            let title = alert.textFields?.first?.text ?? ""
            
            let task = Task(id: "", title: title, status: .wip(Date()), order: 0)
            ServiceLocator.shared.taskService().create(task) { result in
                print(result)
            }
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        viewController?.present(alert, animated: true, completion: nil)
    }

}
