import UIKit

protocol HomePresentationLogic {
    func presentSomething(response: Home.Something.Response)
}

class HomePresenter {
    weak var display: HomeDisplayLogic?
  
}

extension HomePresenter: HomePresentationLogic {
    
    func presentSomething(response: Home.Something.Response) {
        let viewModel = Home.Something.ViewModel(identifier: response.identifier)
        display?.displaySomething(viewModel: viewModel)
    }

}
