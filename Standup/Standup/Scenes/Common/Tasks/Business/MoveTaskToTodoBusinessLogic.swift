import Foundation

protocol MoveTaskToTodoBusinessLogic {
    
    func moveTaskToTodo(request: MoveTask.ToTodo.Request)

}

protocol DefaultMoveTaskToTodoBusinessLogic: MoveTaskToTodoBusinessLogic, ProvidesAllTasks, FiltersTodoTasks {
    
    var taskReorderer: TaskReorderer? { get }
    var taskService: TaskService? { get }

    func updatedStatus(forTaskMovedToTodo task: Task) -> Task.Status
    func didMoveTask(_ task: Task, toTodoCausingUpdatesTo updated: [Task])
    func didntMoveTask(_ task: Task, toTodoDueTo error: Error)
    
}

extension DefaultMoveTaskToTodoBusinessLogic where Self: TaskDataStore {
    
    func moveTaskToTodo(request: MoveTask.ToTodo.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        
        let todo = todoTasks(from: tasks)
        let status = updatedStatus(forTaskMovedToTodo: task)

        let toUpdate = taskReorderer?.reorderTasks(todo, toInclude: task, atPosition: request.position) {
            return $0.withStatus(status)
        } ?? []
        
        taskService?.batchUpdate(toUpdate) { result in
            switch result {
            case .success(let updated):
                self.didMoveTask(task, toTodoCausingUpdatesTo: updated)
            case .failure(let error):
                self.didntMoveTask(task, toTodoDueTo: error)
            }
        }

    }

    func updatedStatus(forTaskMovedToTodo task: Task) -> Task.Status {
        return .todo(Date())
    }

}

extension DefaultMoveTaskToTodoBusinessLogic where Self: KeyedTasksDataStore {
    
    func didMoveTask(_ task: Task, toTodoCausingUpdatesTo updated: [Task]) {
        keyedTasks += updated.toKeyedDictionary()
    }
    
}

extension MoveTask {
    
    struct ToTodo {
        typealias Request = MoveTask.MoveTaskPositionalRequest
    }
    
}

