import UIKit


protocol DoneTasksBusinessLogic: MoveTaskToTodayBusinessLogic, MoveTaskToTrashBusinessLogic {
    func fetchDoneTasks(request: DoneTasks.Fetch.Request)
}

protocol DoneTasksDataStore {
}

class DoneTasksInteractor: DoneTasksDataStore, KeyedTasksDataStore, FiltersDoneTasks {
    var presenter: DoneTasksPresentationLogic?
    var taskService: TaskService?
    lazy var taskReorderer: TaskReorderer? = {
        return DefaultTaskReorderer(dataStore: self)
    }()
    var keyedTasks: [Task.ID: Task] = [:] {
        didSet {
            displayTasks()
        }
    }
    
    func displayTasks() {
        let done = doneTasks(from: tasks)
        let response = DoneTasks.Fetch.Response(tasks: done.toIdentifiableTasks())
        presenter?.presentDoneTasks(response: response)
    }

}

extension DoneTasksInteractor: DoneTasksBusinessLogic {
    
    func fetchDoneTasks(request: DoneTasks.Fetch.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }

}

extension DoneTasksInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        keyedTasks = fetched.toKeyedDictionary()
    }
    
    func didntFetchTasks(dueToError error: Error) {
        // TODO
    }
    
}

extension DoneTasksInteractor: DefaultMoveTaskToTodayBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTodayDueTo error: Error) {
        
    }
    
}

extension DoneTasksInteractor: DefaultMoveTaskToTrashBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTrashDueTo error: Error) {
        
    }
    
}
