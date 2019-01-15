import Foundation

protocol MoveTaskToTodayBusinessLogic {

    func moveTaskToToday(request: MoveTask.ToToday.Request)
    
}

protocol DefaultMoveTaskToTodayBusinessLogic: class, MoveTaskToTodayBusinessLogic, ProvidesAllTasks, FiltersTodayTasks {
    
    var taskReorderer: TaskReorderer? { get }
    var taskService: TaskService? { get }

    func updatedStatus(forTaskMovedToToday task: Task) -> Task.Status
    func didMoveTask(_ task: Task, toTodayCausingUpdatesTo updated: [Task])
    func didntMoveTask(_ task: Task, toTodayDueTo error: Error)
}

extension DefaultMoveTaskToTodayBusinessLogic where Self: TaskDataStore {
    
    func moveTaskToToday(request: MoveTask.ToToday.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }

        let today = todayTasks(from: tasks)
        let status = updatedStatus(forTaskMovedToToday: task)
        
        let toUpdate = taskReorderer?.reorderTasks(today, toInclude: task, atPosition: request.position) {
            return $0.withStatus(status)
        } ?? []
        
        taskService?.batchUpdate(toUpdate) { result in
            switch result {
            case .success(let updated):
                self.didMoveTask(task, toTodayCausingUpdatesTo: updated)
            case .failure(let error):
                self.didntMoveTask(task, toTodayDueTo: error)
            }
        }
    }

    func updatedStatus(forTaskMovedToToday task: Task) -> Task.Status {
        return .wip(Date())
    }
}

extension DefaultMoveTaskToTodayBusinessLogic where Self: KeyedTasksDataStore {
    
    func didMoveTask(_ task: Task, toTodayCausingUpdatesTo updated: [Task]) {
        keyedTasks += updated.toKeyedDictionary()
    }

}

extension MoveTask {
    
    struct ToToday {
        typealias Request = MoveTask.MoveTaskPositionalRequest
    }
    
}

