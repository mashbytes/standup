import Foundation

protocol TaskDataStore {
    
    func taskForIdentifier(_ identifier: Tasks.DataPassing.TaskIdentifier) -> Task?
    
}
