import Foundation

struct MoveTask {
    
    enum Position {
        case first
        case between(Tasks.DataPassing.TaskIdentifier, Tasks.DataPassing.TaskIdentifier)
        case last
    }
    
    struct MoveTaskPositionalRequest {
        let identifier: Tasks.DataPassing.TaskIdentifier
        let position: Position        
    }
    
    struct TaskRequest {
        let identifier: Tasks.DataPassing.TaskIdentifier
    }

}

typealias FullMoveTasksBusinessLogic = MoveTaskToTodayBusinessLogic & MoveTaskToYesterdayBusinessLogic & MoveTaskToTrashBusinessLogic & MoveTaskToDoneBusinessLogic & MoveTaskToTodoBusinessLogic

