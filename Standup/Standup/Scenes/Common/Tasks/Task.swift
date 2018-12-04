import Foundation

struct Task {
    
    typealias ID = String

    let id: ID
    let title: String
    let description: String?
    let createdDate: Date
    let scheduledDate: Date?
    let completedDate: Date?
    
}

extension Task {
    
    func withCompletedDate(_ date: Date) -> Task {
        return Task(id: id, title: title, description: description, createdDate: createdDate, scheduledDate: scheduledDate, completedDate: date)
    }
    
    func withTitle(_ value: String) -> Task {
        return Task(id: id, title: value, description: description, createdDate: createdDate, scheduledDate: scheduledDate, completedDate: completedDate)
    }
    
    func withDescription(_ value: String?) -> Task {
        return Task(id: id, title: title, description: value, createdDate: createdDate, scheduledDate: scheduledDate, completedDate: completedDate)
    }
    
    func withID(_ value: Task.ID) -> Task {
        return Task(id: value, title: title, description: description, createdDate: createdDate, scheduledDate: scheduledDate, completedDate: completedDate)

    }
}
