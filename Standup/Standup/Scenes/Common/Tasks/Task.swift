import Foundation

struct Task {
    
    typealias ID = String

    let id: ID
    let title: String
    let status: Status
    
    var order: Int {
        switch status {
        case .todo(let order),
             .wip(let order):
            return order
        case .done(let date):
            return Int(date.timeIntervalSince1970.truncatingRemainder(dividingBy: Double(Int.max)))
        }
    }
 
    typealias SortOrder = Int
    
    enum Status {
        case todo(SortOrder)
        case wip(SortOrder)
        case done(Date)
    }
    
}

extension Task {
    
    func withStatus(_ status: Task.Status) -> Task {
        return Task(id: id, title: title, status: status)
    }
    
    func withCompletedDate(_ date: Date) -> Task {
        return Task(id: id, title: title, status: .done(date))
    }
    
    func withTitle(_ value: String) -> Task {
        return Task(id: id, title: value, status: status)
    }
    
    func withID(_ value: Task.ID) -> Task {
        return Task(id: value, title: title, status: status)

    }
}

extension Array where Element == Task {
    
    func toIdentifiableTasks() -> [(Tasks.DataPassing.TaskIdentifier, Task)] {
        return self.map { ($0.id, $0) }
    }
}
