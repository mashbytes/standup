import UIKit

protocol HomeDisplayLogic: class {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

class HomeViewController: UITabBarController {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?.forEach { vc in
            if let navVC = vc as? UINavigationController, let dashboardVC = navVC.topViewController as? DashboardViewController {
                DashboardConfigurator().configure(dashboardVC)
            }
            if let todoVC = vc as? TodoTasksViewController {
                TodoTasksConfigurator().configure(todoVC)
            }
            if let doneVC = vc as? DoneTasksViewController {
                DoneTasksConfigurator().configure(doneVC)
            }
        }
        selectedIndex = 1
    }
    
}

extension HomeViewController: HomeDisplayLogic {
    
    func displaySomething(viewModel: Home.Something.ViewModel) {
    }

}
