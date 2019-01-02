import Foundation

struct Task: Hashable {
    
    typealias ID = String

    let id: ID
    let title: String
    let status: Status
    let order: Int
    
//    var order: Int {
//        switch status {
//        case .todo(let order),
//             .wip(let order):
//            return order
//        case .done(let date):
//            return Int(date.timeIntervalSince1970.truncatingRemainder(dividingBy: Double(Int.max)))
//        }
//    }
//
//    typealias SortOrder = Int
//
    enum Status: Hashable {
        case todo
        case wip
        case done(Date)
    }
    
}

extension Task {
    
    func withStatus(_ status: Task.Status) -> Task {
        return Task(id: id, title: title, status: status, order: order)
    }
    
    func withCompletedDate(_ date: Date) -> Task {
        return Task(id: id, title: title, status: .done(date), order: order)
    }
    
    func withTitle(_ value: String) -> Task {
        return Task(id: id, title: value, status: status, order: order)
    }
    
    func withID(_ value: Task.ID) -> Task {
        return Task(id: value, title: title, status: status, order: order)
    }
    
    func withOrder(_ value: Int) -> Task {
        return Task(id: id, title: title, status: status, order: value)
    }
}

extension Array where Element == Task {
    
    func toIdentifiableTasks() -> [Tasks.IdentifiableTask] {
        return self.map { ($0.id, $0) }
    }
}
