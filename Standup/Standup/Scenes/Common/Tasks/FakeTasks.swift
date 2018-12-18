import Foundation

struct FakeTasks {
    
    static func todo() -> Task {
        let identifier = FakeTasks.IdentifierCache.nextTodo()
        return Task(id: identifier, title: identifier, status: .todo, order: 0)
    }
    
    static func wip() -> Task {
        let identifier = FakeTasks.IdentifierCache.nextWIP()
        return Task(id: identifier, title: identifier, status: .wip, order: 0)
    }
    
    static func doneToday() -> Task {
        let identifier = FakeTasks.IdentifierCache.nextDone()
        return Task(id: identifier, title: identifier, status: .done(today), order: 0)
    }
    
    static func doneYesterday() -> Task {
        let identifier = FakeTasks.IdentifierCache.nextDone()
        return Task(id: identifier, title: identifier, status: .done(yesterday), order: 0)
    }
    
    private static var today: Date {
        return Date()
    }
    
    private static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }
    
    private static var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    struct IdentifierCache {
        static var todo = 0
        static var wip = 0
        static var done = 0
        
        static func nextTodo() -> String {
            todo += 1
            return "todo \(todo)"
        }
        
        static func nextWIP() -> String {
            wip += 1
            return "wip \(wip)"
        }
        
        static func nextDone() -> String {
            done += 1
            return "done \(done)"
        }
        
    }
    

}

