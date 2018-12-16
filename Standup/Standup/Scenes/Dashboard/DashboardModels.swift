import UIKit

enum Dashboard {
    
    struct TaskRequest {
        let identifier: Tasks.DataPassing.TaskIdentifier
    }

    struct MoveTaskRequest {
        let identifier: Tasks.DataPassing.TaskIdentifier
        let position: Position
        
        enum Position {
            case first
            case between(Tasks.DataPassing.TaskIdentifier, Tasks.DataPassing.TaskIdentifier)
            case last
        }
    }
    
    enum MoveTaskToToday {
        typealias Request = MoveTaskRequest
        typealias Response = FetchTasks.Response
        typealias ViewModel = FetchTasks.ViewModel
    }
    
    enum MoveTaskToYesterday {
        typealias Request = MoveTaskRequest
        typealias Response = FetchTasks.Response
        typealias ViewModel = FetchTasks.ViewModel
    }
    
    enum MarkTaskAsDone {
        typealias Request = TaskRequest
        typealias Response = FetchTasks.Response
        typealias ViewModel = FetchTasks.ViewModel
    }

    enum MarkTaskAsTodo {
        typealias Request = TaskRequest
        typealias Response = FetchTasks.Response
        typealias ViewModel = FetchTasks.ViewModel
    }
    
    enum DeleteTask {
        typealias Request = TaskRequest
        typealias Response = FetchTasks.Response
        typealias ViewModel = FetchTasks.ViewModel
    }
    
    enum FetchTasks {
        struct Request { }
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
