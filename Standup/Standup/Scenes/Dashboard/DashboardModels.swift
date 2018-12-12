import UIKit

enum Dashboard {

    enum FetchTasks {
        struct Request {
            
        }
        struct Response {
            let yesterday: [IdentifiableTask]
            let today: [IdentifiableTask]
            
            struct IdentifiableTask {
                let identifier: Tasks.DataPassing.TaskIdentifier
                let task: Task
            }
        }
        struct ViewModel {
            
            typealias Task = Tasks.ViewModel.Task
            typealias Section = Tasks.List.ViewModel.Section

            let sections: [Section]
            
        }
        
    }
}
