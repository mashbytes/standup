import Foundation
import UIKit

protocol ControllerConfigurator {
    associatedtype ControllerType: UIViewController
    
    func configure(_ target: ControllerType)
    
}

struct AnyControllerConfigurator<ControllerType: UIViewController>: ControllerConfigurator {
    
    private let configureFn: (ControllerType) -> ()
    
    init<C: ControllerConfigurator>(_ configurator: C) where C.ControllerType == ControllerType {
        configureFn = configurator.configure
    }
    
    func configure(_ target: ControllerType) {
        configureFn(target)
    }
}
