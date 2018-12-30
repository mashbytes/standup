import Foundation


protocol TaskBusinessLogic {


    func moveTask(request: Tasks.MoveTask.Request)
    
}

protocol DefaultTaskBusinessLogic: class, TaskBusinessLogic, DefaultMoveTaskToTodayBusinessLogic, DefaultMoveTaskToYesterdayBusinessLogic, DefaultMoveTaskToTodoBusinessLogic, DefaultMoveTaskToDoneBusinessLogic, DefaultMoveTaskToTrashBusinessLogic {
    
    var taskService: TaskService? { get }
    var keyedTasks: [Task.ID: Task] { get set }
    
    func displayTasks()
}

extension DefaultTaskBusinessLogic {
    
    var tasks: [Task] {
        return Array(keyedTasks.values)
    }

    func didMoveTask(_ task: Task, causingTasksToBeUpdated updated: [Task]) {
        taskService?.batchUpdate(updated, callback: processBatchUpdateResult)
    }
    
    func deleteTask(_ task: Task) {
        taskService?.delete(task.id) { result in
            switch result {
            case .success:
                self.keyedTasks.removeValue(forKey: task.id)
                self.displayTasks()
            case .failure:
                self.displayTasks()
            }
            
        }
    }
    
    func taskForIdentifier(_ identifier: Tasks.DataPassing.TaskIdentifier) -> Task? {
        return keyedTasks[identifier]
    }

    func moveTask(request: Tasks.MoveTask.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        
        switch request.target {
        case .today(let position): moveTask(task, toTodayPositionedAt: position)
        case .yesterday(let position): moveTask(task, toYesterdayPositionedAt: position)
        case .todo: moveTask(task, toTodoPositionedAt: .first)
        case .done: moveTask(task, toDonePositionedAt: .first)
        case .trash: moveTaskToTrash(task)
        }
    }
    
    
    private func processBatchUpdateResult(_ result: Result<[Task]>) {
        switch result {
        case .success(let updated):
            updated.forEach {
                keyedTasks[$0.id] = $0
            }
            displayTasks()
        case .failure:
            displayTasks()
        }
    }


}
