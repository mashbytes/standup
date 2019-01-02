import Foundation

protocol MoveTaskToDoneBusinessLogic {
    
    func moveTaskToDone(request: MoveTask.ToDone.Request)

}

protocol DefaultMoveTaskToDoneBusinessLogic: MoveTaskToDoneBusinessLogic, ProvidesAllTasks, FiltersDoneTasks {
    
    var taskReorderer: TaskReorderer? { get }
    var taskService: TaskService? { get }

    func didMoveTask(_ task: Task, toDoneCausingUpdatesTo updated: [Task])
    func didntMoveTask(_ task: Task, toDoneDueTo error: Error)

}

extension DefaultMoveTaskToDoneBusinessLogic where Self: TaskDataStore {
    
    func moveTaskToDone(request: MoveTask.ToDone.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        
        let done = doneTasks(from: tasks)

        let toUpdate = taskReorderer?.reorderTasks(done, toInclude: task, atPosition: request.position) {
            return $0.withCompletedDate(Date())
        } ?? []
        
        taskService?.batchUpdate(toUpdate) { result in
            switch result {
            case .success(let updated):
                self.didMoveTask(task, toDoneCausingUpdatesTo: updated)
            case .failure(let error):
                self.didntMoveTask(task, toDoneDueTo: error)
            }
        }

    }

}

extension DefaultMoveTaskToDoneBusinessLogic where Self: KeyedTasksDataStore {
    
    func didMoveTask(_ task: Task, toDoneCausingUpdatesTo updated: [Task]) {
        keyedTasks += updated.toKeyedDictionary()
    }
    
}

extension MoveTask {
    
    struct ToDone {
        typealias Request = MoveTask.MoveTaskPositionalRequest
    }
    
}

