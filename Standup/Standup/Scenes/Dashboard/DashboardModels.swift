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
            let sections: [Section]
            
            struct Section {
                let title: String
                let tasks: [Tasks.ViewModel.Task]
            }
                        
        }
        
    }
}
