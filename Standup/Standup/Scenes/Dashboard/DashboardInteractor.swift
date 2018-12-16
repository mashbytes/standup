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
            .sorted { $0.order < $1.order }
    }
    
    private var yesterday: [Task] {
        return tasks.values
            .filter { task in
                switch task.status {
                case .done(let date) where calendar.isDateInYesterday(date): return true
                default: return false
                }
            }
            .sorted { $0.order < $1.order }
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
        guard let task = taskForIdentifier(request.identifier), let toUpdate = updatedTask(task, toPosition: request.position, in: today) else {
            return
        }
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
    
    func moveTaskToYesterday(request: Dashboard.MoveTaskToYesterday.Request) {
        guard let task = taskForIdentifier(request.identifier), let toUpdate = updatedTask(task, toPosition: request.position, in: yesterday) else {
            return
        }
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
        let toUpdate = task.withStatus(.todo(0))
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
    
    private func updatedTask(_ task: Task, toPosition position: Dashboard.MoveTaskToToday.Request.Position, in section: [Task]) -> Task? {
        switch position {
        case .first:
            let existingFirstTaskOrder = section.first?.order ?? 100
            return task.withStatus(.wip(existingFirstTaskOrder - 100))
        case .between(let after, let before):
            guard let afterTask = taskForIdentifier(after), let beforeTask = taskForIdentifier(before) else {
                return nil
            }
            let order = (beforeTask.order - afterTask.order) / 2
            return task.withStatus(.wip(order))
        case .last:
            let existingLastTaskOrder = section.last?.order ?? -100
            return task.withStatus(.wip(existingLastTaskOrder + 100))
        }
    }

}
