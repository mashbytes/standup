import Foundation
import AWSAppSync

struct AWSTaskService: TaskService {
    
    let client: AWSAppSyncClient
    
    func create(_ task: Task, callback: @escaping (Result<Task>) -> Void) {
        let status = task.status.toDTO()
        let input = CreateTaskInput(id: GraphQLID(), title: task.title, status: status, order: task.order)
        let mutation = CreateTaskMutation(input: input)
        client.perform(mutation: mutation) { result, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            if let resultError = result?.errors?.first {
                callback(.failure(resultError))
                print("Error saving the item on server: \(resultError)")
                return
            }
            guard let task = result?.data?.createTask, let model = task.toModel() else {
                // TODO
                return
            }
            
            callback(.success(model))
        }
    }
    
    func retrieve(callback: @escaping (Result<[Task]>) -> Void) {
        let query = ListTasksQuery()
        client.fetch(query: query) { result, error in
            if let error = error {
                callback(.failure(error))
                return
            }
            guard let items = result?.data?.listTasks?.items else {
//                callback(.failure(error)) // TODO
                return

            }
            let transformer = TaskDTOTransformer()
            let transformed = items.compactMap { $0 }.compactMap(transformer.transform)
            callback(.success(transformed))
            
        }
    }
    
    func update(_ task: Task, callback: @escaping (Result<Task>) -> Void) {
        
    }
    
    func batchUpdate(_ tasks: [Task], callback: @escaping (Result<[Task]>) -> Void) {
        
    }
    
    func delete(_ id: Task.ID, callback: @escaping (Result<Void>) -> Void) {
        
    }
    

}

struct TaskDTOTransformer {
    
    private let formatter = ISO8601DateFormatter()
    
    func transform(dto: ListTasksQuery.Data.ListTask.Item) -> Task? {
        guard let status = extractStatus(dto: dto) else {
            return nil
        }
        return Task(id: dto.id, title: dto.title, status: status, order: dto.order)
    }
    
    private func extractStatus(dto: ListTasksQuery.Data.ListTask.Item) -> Task.Status? {
        var date = Date()
        // TODO make mandatory
        if let statusDate = dto.statusDate {
            date = formatter.date(from: statusDate) ?? date
        }
        switch dto.status {
        case .done: return .done(date)
        case .wip: return .wip(date)
        case .todo: return .todo(date)
        case .unknown: return nil
        }
    }
    
}

private extension Task {
    
    var statusDate: Date {
        switch status {
        case .done(let date): return date
        default: return Date() // TODO have dates for all status
        }
    }
    
    
    
}

private extension Task.Status {
    
    func toDTO() -> TaskStatus {
        switch self {
        case .done: return .done
        case .wip: return .wip
        case .todo: return .todo
        }
    }
    
}

private extension CreateTaskMutation.Data.CreateTask {
    
    var formatter: ISO8601DateFormatter {
        return ISO8601DateFormatter()
    }

    
    func toModel() -> Task? {
        guard let status = extractStatus(dto: self) else {
            return nil
        }
        return Task(id: id, title: title, status: status, order: order)

    }
    
    private func extractStatus(dto: CreateTaskMutation.Data.CreateTask) -> Task.Status? {
        var date = Date()
        // TODO make mandatory
        if let statusDate = dto.statusDate {
            date = formatter.date(from: statusDate) ?? date
        }
        switch dto.status {
        case .done: return .done(date)
        case .wip: return .wip(date)
        case .todo: return .todo(date)
        case .unknown: return nil
        }
    }

}
