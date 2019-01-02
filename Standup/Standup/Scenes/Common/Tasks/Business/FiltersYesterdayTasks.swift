import Foundation

protocol FiltersYesterdayTasks {
    
    func yesterdayTasks(from tasks: [Task]) -> [Task]
    
}

extension FiltersYesterdayTasks {
    
    func yesterdayTasks(from tasks: [Task]) -> [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .done(let date) where Calendar.current.isDateInYesterday(date): return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
}


