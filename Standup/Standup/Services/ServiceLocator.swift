import Foundation

class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    private var services: [String: Any] = [:]
    
    func registerService<T>(_ service: T) {
        let key = keyForService(T.self)
        services[key] = service
    }
    
    func locateService<T>() -> T {
        let key = keyForService(T.self)
        guard let found = services[key] as? T else {
            fatalError("No service found for key '\(key)', an implementation must be registered")
        }
        return found
    }
    
    private func keyForService(_ service: Any) -> String {
        return String(describing: service)
    }
    
}
