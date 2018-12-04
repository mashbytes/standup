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
        func toIdentifiableTask(_ task: Task) -> Dashboard.FetchTasks.Response.IdentifiableTask {
            return Dashboard.FetchTasks.Response.IdentifiableTask(identifier: task.id, task: task)
        }
        
        let calendar = Calendar.current
        let groups: [String: [Task]] = Dictionary(grouping: tasks.values) { task in
            let isYesterday = calendar.isDateInYesterday(task.scheduledDate)
            if isYesterday {
                return "yesterday"
            }
            let isToday = calendar.isDateInToday(task.scheduledDate)
            if isToday {
                return "today"
            }
            return "na"
        }
        let yesterday = groups["yesterday"] ?? []
        let today = groups["today"] ?? []
        
        let response = Dashboard.FetchTasks.Response(yesterday: yesterday.map(toIdentifiableTask), today: today.map(toIdentifiableTask))
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

