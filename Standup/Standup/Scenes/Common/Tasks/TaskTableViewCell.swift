import UIKit

struct TaskTableViewCellModel {
    let title: String
    let showTick: Bool
}

class TaskTableViewCell: UITableViewCell, ProvidesNib {
    
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        icon.contentMode = .center
        icon.image = UIImage(named: "tick")?.withRenderingMode(.alwaysTemplate)
        icon.tintColor = .green
        container.backgroundColor = .white
        container.layer.cornerRadius = 5
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        icon.isHidden = true
    }

    func displayModel(_ model: TaskTableViewCellModel) {
        icon.isHidden = !model.showTick
        titleLabel.text = model.title
    }
    
}
