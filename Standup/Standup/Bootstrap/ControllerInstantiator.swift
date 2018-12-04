import Foundation
import UIKit

protocol ControllerInstantiator {
    
    func instantiate<T: UIViewController>() -> T
    
}

