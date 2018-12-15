import UIKit

enum Dashboard {

    enum FetchTasks {
        struct Request {
            
        }
        struct Response {
            let yesterday: [Tasks.IdentifiableTask]
            let today: [Tasks.IdentifiableTask]
        }
        struct ViewModel {
            
            typealias Task = Tasks.ViewModel.Task
            typealias Section = Tasks.List.ViewModel.Section

            let sections: [Section]
            
        }
        
    }
}
