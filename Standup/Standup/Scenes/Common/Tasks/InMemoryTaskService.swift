import Foundation

class InMemoryTaskService: TaskService {
    
    static var shared = InMemoryTaskService(initial: [FakeTasks.todo(), FakeTasks.todo(), FakeTasks.doneToday(), FakeTasks.wip(), FakeTasks.doneYesterday()])
    
    private var tasks: [Task.ID: Task] = [:]
    
    init(initial: [Task] = []) {
        initial.forEach { task in
            tasks[task.id] = task
        }
    }
    
    func delete(_ id: Task.ID, callback: @escaping (Result<Void>) -> Void) {
        guard let _ = tasks.removeValue(forKey: id) else {
            callback(.failure(TaskServiceError.notFound))
            return
        }
        callback(.success(()))
    }
    
    func update(_ task: Task, callback: @escaping (Result<Task>) -> Void) {
        tasks[task.id] = task
        callback(.success(task))
    }
    
    func batchUpdate(_ tasks: [Task], callback: @escaping (Result<[Task]>) -> Void) {
        tasks.forEach {
            self.tasks[$0.id] = $0
        }
        callback(.success(tasks))
    }
    
    func create(_ task: Task, callback: @escaping (Result<Task>) -> Void) {
        let id = UUID().uuidString
        let created = task.withID(id)
        tasks[task.id] = created
        callback(.success(created))
    }
    
    func retrieve(callback: @escaping (Result<[Task]>) -> Void) {
        callback(.success(Array(tasks.values)))
    }
    
}

