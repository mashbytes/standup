import Foundation
import UIKit

enum DefaultControllerInstantiator: ControllerInstantiator {
    case nib(ControllerNamingStrategy)
    case storyboard(ControllerNamingStrategy)
    
    func instantiate<T: UIViewController>() -> T {
        let bundle = Bundle(for: T.self)
        switch self {
        case .storyboard(let strategy): return UIStoryboard(name: strategy.name(), bundle: bundle).instantiateInitialViewController() as! T
        case .nib(let strategy): return T(nibName: strategy.name(), bundle: bundle)
        }
    }
}

extension InstantiatedWithMatchingNibName where Self: UIViewController {
    
    static var instantiator: ControllerInstantiator {
        return DefaultControllerInstantiator.nib(DefaultControllerNamingStrategy.namedAfter(Self.self))
    }
    
}

extension InstantiatedWithoutViewControllerSuffixStoryboardName where Self: UIViewController {
    
    static var instantiator: ControllerInstantiator {
        return DefaultControllerInstantiator.storyboard(DefaultControllerNamingStrategy.namedAfterWithoutViewControllerSuffix(Self.self))
    }
    
}

