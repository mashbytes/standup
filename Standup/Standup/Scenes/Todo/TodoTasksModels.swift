import UIKit

enum TodoTasks {
    
    struct DataPassing {
        typealias TaskIdentifier = Task.ID
    }
    
    enum Fetch {
        struct Request { }
        struct Response {
            let tasks: [(DataPassing.TaskIdentifier, Task)]
        }
        struct ViewModel {
            typealias Section = Tasks.List.ViewModel.Section
            
            let section: Section
        }
    }
    
}
