import Foundation

struct Tasks {
    
    typealias IdentifiableTask = (DataPassing.TaskIdentifier, Task)

    struct ViewModel {
        
        struct Task: Codable {
            let identifier: DataPassing.TaskIdentifier
            let title: String
            let completedDate: String?
            let actions: [Action]
            
            var isCompleted: Bool {
                return completedDate != nil
            }
            
            enum Action: Int, Codable {
                case start
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
    
    struct MoveTask {
        
        enum Target {
            case todo
            case yesterday(Position)
            case today(Position)
            case done
            case trash
        }
        
        enum Position {
            case first
            case between(Tasks.DataPassing.TaskIdentifier, Tasks.DataPassing.TaskIdentifier)
            case last
        }
        
        struct Request {
            let identifier: Tasks.DataPassing.TaskIdentifier
            let target: Target
        }
        
        typealias Response = List.Response
        
    }
}
