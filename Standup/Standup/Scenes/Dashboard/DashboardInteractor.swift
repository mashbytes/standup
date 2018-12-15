import UIKit


protocol DashboardBusinessLogic: DeleteTaskBusinessLogic, CompleteTaskBusinessLogic, FetchTasksBusinessLogic {

}

protocol DashboardDataStore {
}

class DashboardInteractor: DashboardDataStore {
    var presenter: DashboardPresentationLogic?
    var taskService: TaskService?
    
    private var tasks: [Task.ID: Task] = [:]
}

extension DashboardInteractor: DashboardBusinessLogic {

    
    private func displayTasks() {
        
        
        let calendar = Calendar.current
        let groups: [String: [Task]] = Dictionary(grouping: tasks.values) { task in
            switch task.status {
            case .done(let date) where calendar.isDateInYesterday(date): return "yesterday"
            case .done(let date) where calendar.isDateInToday(date): fallthrough
            case .wip: return "today"
            default: return "na"
            }
        }
        let yesterday = groups["yesterday"] ?? []
        let today = groups["today"] ?? []
        
        let response = Dashboard.FetchTasks.Response(yesterday: yesterday.toIdentifiableTasks(), today: today.toIdentifiableTasks())
        presenter?.presentTasks(response: response)
    }
    
    
}

extension DashboardInteractor: TaskDataStore {
    
    func taskForIdentifier(_ identifier: Tasks.DataPassing.TaskIdentifier) -> Task? {
        return tasks[identifier]
    }
}

extension DashboardInteractor: DefaultDeleteTaskBusinessLogic {
    func didDeleteTask(withIdentifier identifier: Tasks.DataPassing.TaskIdentifier) {
        tasks.removeValue(forKey: identifier)
        displayTasks()
    }
    
    func didntDeleteTask(withIdentifier identifier: Tasks.DataPassing.TaskIdentifier, dueToError error: Error) {
        
    }
    
    
}

extension DashboardInteractor: DefaultCompleteTaskBusinessLogic {

    func didCompleteTask(_ task: Task) {
        tasks[task.id] = task
        displayTasks()
    }
    
    func didntCompleteTask(withIdentifier identifier: Tasks.DataPassing.TaskIdentifier, dueToError error: Error) {
        
    }
}

extension DashboardInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        tasks.removeAll()
        fetched.forEach { task in
            tasks[task.id] = task
        }
        
        displayTasks()
    }
    
    func didntFetchTasks(dueToError error: Error) {
        
    }
}

