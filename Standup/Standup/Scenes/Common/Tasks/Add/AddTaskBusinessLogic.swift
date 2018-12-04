import Foundation

protocol AddTaskBusinessLogic {
    
    func addTask(request: Tasks.Add.Request)
    
}

protocol DefaultAddTaskBusinessLogic: AddTaskBusinessLogic {
    
    var taskService: TaskService? { get }

    func didAddTask(_ task: Task)
    func didntAddTask(dueToError error: Error)

}

extension DefaultAddTaskBusinessLogic {
    
    func addTask(request: Tasks.Add.Request) {
        let new = Task(id: "", title: request.title, description: request.description, createdDate: Date(), scheduledDate: request.scheduledDate ?? Date(), completedDate: nil)
        taskService?.create(new) { result in
            switch result {
            case .success(let added):
                self.didAddTask(added)
            case .failure(let error):
                self.didntAddTask(dueToError: error)
            }
        }
    }
}
