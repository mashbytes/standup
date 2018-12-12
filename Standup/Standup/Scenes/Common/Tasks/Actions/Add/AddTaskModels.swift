import Foundation

extension Tasks {
    
    enum Add {
        struct Request {
            let title: String
            let description: String?
            let scheduledDate: Date?
        }
        struct Response {
            let task: Task
        }
        struct ViewModel {
            let task: Tasks.ViewModel.Task
        }
    }
    
}
