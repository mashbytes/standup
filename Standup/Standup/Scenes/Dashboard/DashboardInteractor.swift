import UIKit


protocol DashboardBusinessLogic: TaskBusinessLogic {

    func fetchTasks(request: Dashboard.FetchTasks.Request)
    
}

protocol DashboardDataStore: TaskDataStore {
}

class DashboardInteractor: DashboardDataStore {
    var presenter: DashboardPresentationLogic?
    var taskService: TaskService?
    lazy var taskReorderer: TaskReorderer = {
        return DefaultTaskReorderer(dataStore: self)
    }()
    var keyedTasks: [Task.ID: Task] = [:]

    private let calendar = Calendar.current
}

extension DashboardInteractor: DashboardBusinessLogic {

    func fetchTasks(request: Dashboard.FetchTasks.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }
    
}

extension DashboardInteractor: DefaultTaskBusinessLogic {
    
    func displayTasks() {
        let response = Dashboard.FetchTasks.Response(yesterday: yesterday.toIdentifiableTasks(), today: today.toIdentifiableTasks())
        presenter?.presentTasks(response: response)
    }
    
}

extension DashboardInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        keyedTasks = fetched.toKeyedDictionary()
        displayTasks()
    }
    
    func didntFetchTasks(dueToError error: Error) {
        // TODO
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

