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
            if let dashboardVC = vc as? DashboardViewController {
                DashboardConfigurator().configure(dashboardVC)
            }
        }
    }
    
}

extension HomeViewController: HomeDisplayLogic {
    
    func displaySomething(viewModel: Home.Something.ViewModel) {
    }

}
