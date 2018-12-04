import UIKit

enum TodoTasks {
    
    struct DataPassing {
        enum SectionIdentifier {
            case scheduled(Date)
            case unscheduled
            
        }
    }
    

    enum Fetch {
        struct Request { }
        struct Response {
            let sections: [Section]
            
            struct Section {
                let identifier: DataPassing.SectionIdentifier
                let date: Date?
                let tasks: [Tasks.DataPassing.TaskIdentifier: Task]
            }
            
        }
        struct ViewModel {
            typealias Section = Tasks.ViewModel.Group<DataPassing.SectionIdentifier>
            
            let sections: [Section]
        }
    }
    
}
