import Foundation

protocol TaskDataStore {
    
    func taskForIdentifier(_ identifier: Tasks.DataPassing.TaskIdentifier) -> Task?
    
}

protocol KeyedTasksDataStore: class, TaskDataStore, ProvidesAllTasks {
    
    var keyedTasks: [Task.ID: Task] { get set }

}

protocol ProvidesAllTasks {
    
    var tasks: [Task] { get }
    
}

extension KeyedTasksDataStore {
    
    var tasks: [Task] {
        return Array(keyedTasks.values)
    }

    func taskForIdentifier(_ identifier: Tasks.DataPassing.TaskIdentifier) -> Task? {
        return keyedTasks[identifier]
    }
    
}
