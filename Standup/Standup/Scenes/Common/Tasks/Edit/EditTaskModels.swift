import Foundation

extension Tasks {
    
    enum Edit {
        struct Request {
            let identifier: DataPassing.TaskIdentifier
            let title: String
            let description: String
        }
    }
    
}
