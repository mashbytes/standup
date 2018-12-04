import Foundation
import UIKit

protocol ProvidesControllerConfigurator {
    associatedtype ControllerType: UIViewController
    
    static var configurator: AnyControllerConfigurator<ControllerType> { get }
}
