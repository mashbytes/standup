import Foundation
import UIKit

protocol ProvidesNib {
    static var nib: UINib { get }
}

extension ProvidesNib where Self: UITableViewCell {
    
    static var nibName: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

}

extension UITableView {
    
    func register<T: UITableViewCell & ProvidesNib>(_ cell: T.Type) {
        let reuseIdentififer = reuseIdentifierForCell(T.self)
        register(T.nib, forCellReuseIdentifier: reuseIdentififer)
    }
    
    func dequeCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let reuseIdentififer = reuseIdentifierForCell(T.self)
        guard let cell = dequeueReusableCell(withIdentifier: reuseIdentififer, for: indexPath) as? T else {
            fatalError("Expected a registered cell for type \(T.self)")
        }
        return cell
    }
    
    private func reuseIdentifierForCell<T: UITableViewCell>(_ cell: T.Type) -> String {
        return String(describing: cell)
    }
    
}
