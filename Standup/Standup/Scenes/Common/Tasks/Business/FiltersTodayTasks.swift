import Foundation

protocol FiltersTodayTasks {
    
    func todayTasks(from tasks: [Task]) -> [Task]

}

extension FiltersTodayTasks {
    
    func todayTasks(from tasks: [Task]) -> [Task] {
        return tasks
            .filter { task in
                switch task.status {
                case .done(let date) where Calendar.current.isDateInToday(date): return true
                case .wip: return true
                default: return false
                }
            }
            .sortedByOrder()
    }
    
}


