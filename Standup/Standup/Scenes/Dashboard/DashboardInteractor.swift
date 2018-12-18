import UIKit


protocol DashboardBusinessLogic {

    func fetchTasks(request: Dashboard.FetchTasks.Request)
    func moveTaskToToday(request: Dashboard.MoveTaskToToday.Request)
    func moveTaskToYesterday(request: Dashboard.MoveTaskToYesterday.Request)
    func deleteTask(request: Dashboard.DeleteTask.Request)
    func markTaskAsDone(request: Dashboard.MarkTaskAsDone.Request)
    func markTaskAsTodo(request: Dashboard.MarkTaskAsTodo.Request)
    
}

protocol DashboardDataStore: TaskDataStore {
}

class DashboardInteractor: DashboardDataStore {
    var presenter: DashboardPresentationLogic?
    var taskService: TaskService?
    
    private let calendar = Calendar.current

    private var tasks: [Task.ID: Task] = [:]
    
    private var today: [Task] {
        return tasks.values
            .filter { task in
                switch task.status {
                case .done(let date) where calendar.isDateInToday(date): return true
                case .wip: return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
    private var yesterday: [Task] {
        return tasks.values
            .filter { task in
                switch task.status {
                case .done(let date) where calendar.isDateInYesterday(date): return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
    func taskForIdentifier(_ identifier: Tasks.DataPassing.TaskIdentifier) -> Task? {
        return tasks[identifier]
    }

}

extension DashboardInteractor: DashboardBusinessLogic {

    func fetchTasks(request: Dashboard.FetchTasks.Request) {
        taskService?.retrieve { result in
            switch result {
            case .success(let tasks):
                self.tasks = tasks.reduce([:]) { acc, next in
                    var map = acc
                    map[next.id] = next
                    return map
                }
                self.displayTasks()
            case .failure:
                self.displayTasks()
            }
        }
    }
    
    func moveTaskToToday(request: Dashboard.MoveTaskToToday.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        
        func updatedStatus() -> Task.Status {
            switch task.status {
            case .done: return .done(Date())
            default: return .wip
            }
        }
        
        let toUpdate = reorderTasks(today, toInclude: task, atPosition: request.position) {
            return $0.withStatus(updatedStatus())
        }
        
        taskService?.batchUpdate(toUpdate, callback: processBatchUpdateResult)
    }
    
    func moveTaskToYesterday(request: Dashboard.MoveTaskToYesterday.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        
        let toUpdate = reorderTasks(yesterday, toInclude: task, atPosition: request.position) {
            return $0.withCompletedDate(Date().addingTimeInterval(-1.days))
        }

        taskService?.batchUpdate(toUpdate, callback: processBatchUpdateResult)
    }
    
    private func processBatchUpdateResult(_ result: Result<[Task]>) {
        switch result {
        case .success(let updated):
            updated.forEach {
                self.tasks[$0.id] = $0
            }
            self.displayTasks()
        case .failure:
            self.displayTasks()
        }
    }
    
    func deleteTask(request: Dashboard.DeleteTask.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        taskService?.delete(task.id) { result in
            switch result {
            case .success:
                self.tasks.removeValue(forKey: request.identifier)
                self.displayTasks()
            case .failure:
                self.displayTasks()
            }
        }
    }
    
    func markTaskAsDone(request: Dashboard.MarkTaskAsDone.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        let toUpdate = task.withCompletedDate(Date())
        taskService?.update(toUpdate) { result in
            switch result {
            case .success(let updated):
                self.tasks[updated.id] = updated
                self.displayTasks()
            case .failure:
                self.displayTasks()
            }
        }
    }

    func markTaskAsTodo(request: Dashboard.MarkTaskAsTodo.Request) {
        guard let task = taskForIdentifier(request.identifier) else {
            return
        }
        let toUpdate = task.withStatus(.todo)
        taskService?.update(toUpdate) { result in
            switch result {
            case .success(let updated):
                self.tasks[updated.id] = updated
                self.displayTasks()
            case .failure:
                self.displayTasks()
            }
        }
    }

    private func displayTasks() {
        let response = Dashboard.FetchTasks.Response(yesterday: yesterday.toIdentifiableTasks(), today: today.toIdentifiableTasks())
        presenter?.presentTasks(response: response)
    }
    
    private func reorderTasks(_ tasks: [Task], toInclude task: Task, atPosition position: Dashboard.MoveTaskRequest.Position, applyingTransformation transformer: (Task) -> Task) -> [Task] {
        let ordered = Set(tasks).subtracting([task]).sortedByOrder()
        let updatedTask = transformer(task)
        
        func reorderTasksForPosition() -> [Task] {
            switch position {
            case .first: return ([updatedTask] + ordered)
            case .between(let after, let before):
                guard let afterTask = taskForIdentifier(after), let beforeTask = taskForIdentifier(before) else {
                    return ordered
                }
                
                guard let afterIndex = ordered.firstIndex(of: afterTask), let beforeIndex = ordered.firstIndex(of: beforeTask) else {
                    return ordered
                }
                
                return Array(ordered.prefix(through: afterIndex) + [updatedTask] + ordered.suffix(from: beforeIndex))
            case .last:
                return (ordered + [updatedTask])
            }
        }

        return reorderTasksForPosition()
            .enumerated()
            .map { offset, next in
                return next.withOrder(offset)
            }
    }

}

extension Sequence where Element == Task {
    
    func sortedByOrder() -> [Element] {
        return sorted { $0.order < $1.order }
    }
    
}
