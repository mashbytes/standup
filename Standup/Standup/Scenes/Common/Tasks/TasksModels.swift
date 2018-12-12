import Foundation

struct Tasks {

    struct ViewModel {
        
        struct Task: Codable {
            let identifier: DataPassing.TaskIdentifier
            let title: String
            let description: String?
            let createdDate: String
            let completedDate: String?
            let actions: [Action]
            
            var isCompleted: Bool {
                return completedDate != nil
            }
            
            enum Action: Int, Codable {
                case markComplete
                case markIncomplete
                case delete
            }
        }
        
        struct Group<I> {
            let identifier: I
            let title: String
            let tasks: [Task]
        }

    }
    
    struct List {
        
        struct Request { }
        struct Response {
            let tasks: [Task]
        }
        struct ViewModel {
            let sections: [Section]
            
            struct Section {
                let title: String
                let tasks: [Tasks.ViewModel.Task]
            }
        }
        
    }

    
    struct DataPassing {
        typealias TaskIdentifier = Task.ID
    }
    
}
