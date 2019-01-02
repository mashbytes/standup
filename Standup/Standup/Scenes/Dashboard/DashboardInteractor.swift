import UIKit


protocol DashboardBusinessLogic: MoveTaskToTodoBusinessLogic, MoveTaskToTrashBusinessLogic, MoveTaskToYesterdayBusinessLogic, MoveTaskToTodayBusinessLogic, MoveTaskToDoneBusinessLogic {

    func fetchTasks(request: Dashboard.FetchTasks.Request)
    
}

protocol DashboardDataStore: TaskDataStore {
}

class DashboardInteractor: DashboardDataStore, KeyedTasksDataStore, FiltersYesterdayTasks, FiltersTodayTasks {
    var presenter: DashboardPresentationLogic?
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
        let yesterday = yesterdayTasks(from: tasks)
        let today = todayTasks(from: tasks)
        let response = Dashboard.FetchTasks.Response(yesterday: yesterday.toIdentifiableTasks(), today: today.toIdentifiableTasks())
        presenter?.presentTasks(response: response)
    }

}

extension DashboardInteractor: DashboardBusinessLogic {

    func fetchTasks(request: Dashboard.FetchTasks.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }
    
}

extension DashboardInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        keyedTasks = fetched.toKeyedDictionary()
    }
    
    func didntFetchTasks(dueToError error: Error) {
        // TODO
    }
    
}



extension DashboardInteractor: DefaultMoveTaskToTodayBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTodayDueTo error: Error) {
        
    }
    
}

extension DashboardInteractor: DefaultMoveTaskToYesterdayBusinessLogic {
    
    func didntMoveTask(_ task: Task, toYesterdayDueTo error: Error) {
    }
    
}

extension DashboardInteractor: DefaultMoveTaskToDoneBusinessLogic {
    
    func didntMoveTask(_ task: Task, toDoneDueTo error: Error) {
        
    }
    
}

extension DashboardInteractor: DefaultMoveTaskToTrashBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTrashDueTo error: Error) {
        
    }
    
}

extension DashboardInteractor: DefaultMoveTaskToTodoBusinessLogic {
    
    func didntMoveTask(_ task: Task, toTodoDueTo error: Error) {
        
    }
    
}


extension Array where Element == Task {
    
    func toKeyedDictionary() -> Dictionary<Task.ID, Task> {
        return reduce([:]) { acc, next in
            var map = acc
            map[next.id] = next
            return map
        }
    }
    
}

