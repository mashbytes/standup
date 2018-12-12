import UIKit


protocol TodoTasksBusinessLogic {
    func fetchTodoTasks(request: TodoTasks.Fetch.Request)
}

protocol TodoTasksDataStore {
}

class TodoTasksInteractor: TodoTasksDataStore {
    var presenter: TodoTasksPresentationLogic?
    var taskService: TaskService?

}

extension TodoTasksInteractor: TodoTasksBusinessLogic {
    
    func fetchTodoTasks(request: TodoTasks.Fetch.Request) {
        fetchTasks(request: Tasks.Fetch.Request())
    }

}

extension TodoTasksInteractor: DefaultFetchTasksBusinessLogic {
    
    func didFetchTasks(_ fetched: [Task]) {
        let calendar = Calendar.current
        let todoTasks = fetched.filter { task in
            guard task.completedDate == nil else {
                return false
            }
            guard let scheduled = task.scheduledDate else {
                return true
            }
            return !calendar.isDateInToday(scheduled)
        }
        let byDate = Dictionary(grouping: todoTasks) { $0.scheduledDate }
        
        let sections = byDate.map { pair -> TodoTasks.Fetch.Response.Section in
            let (date, tasks) = pair
            let identifier: TodoTasks.DataPassing.SectionIdentifier = (date == nil ? .unscheduled : .scheduled(date!))
            let mapped = Dictionary(uniqueKeysWithValues: tasks.map { ($0.id, $0) })
            return TodoTasks.Fetch.Response.Section(identifier: identifier, date: date, tasks: mapped)
        }
        
        let response = TodoTasks.Fetch.Response(sections: sections)
        presenter?.presentTodoTasks(response: response)
    }
    
    func didntFetchTasks(dueToError error: Error) {
        
    }

}
