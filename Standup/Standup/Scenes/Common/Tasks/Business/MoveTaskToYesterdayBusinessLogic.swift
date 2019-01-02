import Foundation

protocol MoveTaskToYesterdayBusinessLogic {
    
    func moveTaskToYesterday(request: MoveTask.ToYesterday.Request)

}

protocol DefaultMoveTaskToYesterdayBusinessLogic: MoveTaskToYesterdayBusinessLogic, FiltersYesterdayTasks {
    
    var tasks: [Task] { get }
    var taskReorderer: TaskReorderer? { get }
    var taskService: TaskService? { get }
    
    func didMoveTask(_ task: Task, toYesterdayCausingUpdatesTo updated: [Task])
    func didntMoveTask(_ task: Task, toYesterdayDueTo error: Error)
}

extension DefaultMoveTaskToYesterdayBusinessLogic where Self: TaskDataStore {
    
    func moveTaskToYesterday(request: MoveTask.ToYesterday.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        
        let yesterday = yesterdayTasks(from: tasks)
        
        let toUpdate = taskReorderer?.reorderTasks(yesterday, toInclude: task, atPosition: request.position) {
            return $0.withCompletedDate(Date().addingTimeInterval(-1.days))
        } ?? []
        
        taskService?.batchUpdate(toUpdate) { result in
            switch result {
            case .success(let updated):
                self.didMoveTask(task, toYesterdayCausingUpdatesTo: updated)
            case .failure(let error):
                self.didntMoveTask(task, toYesterdayDueTo: error)
            }
        }
    }

}

extension DefaultMoveTaskToYesterdayBusinessLogic where Self: KeyedTasksDataStore {
    
    func didMoveTask(_ task: Task, toYesterdayCausingUpdatesTo updated: [Task]) {
        keyedTasks += updated.toKeyedDictionary()
    }
    
}


extension MoveTask {
    
    struct ToYesterday {
        typealias Request = MoveTask.MoveTaskPositionalRequest
    }
    
}

