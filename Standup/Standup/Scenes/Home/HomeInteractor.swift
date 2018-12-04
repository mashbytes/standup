import UIKit


protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
}

class HomeInteractor: HomeDataStore {
    var presenter: HomePresentationLogic?

}

extension HomeInteractor: HomeBusinessLogic {
    
    func doSomething(request: Home.Something.Request) {
        
        let response = Home.Something.Response(identifier: Home.Something.DataPassing())
        presenter?.presentSomething(response: response)
    }

}
