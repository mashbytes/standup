import Foundation

protocol TaskService {
    
    func create(_ task: Task, callback: @escaping (Result<Task>) -> Void)
    func retrieve(callback: @escaping (Result<[Task]>) -> Void)
    func update(_ task: Task, callback: @escaping (Result<Task>) -> Void)
    func delete(_ id: Task.ID, callback: @escaping (Result<Void>) -> Void)
    
}

enum TaskServiceError: Error {
    case notFound
}
