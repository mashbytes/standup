import Foundation
import UIKit

class ListTableViewDataSource: NSObject, UITableViewDataSource {
    
    private weak var source: TaskListDataSource?
    
    init(listSource: TaskListDataSource) {
        source = listSource
    }
    
    func prepare(table: UITableView) {
        table.register(TaskTableViewCell.self)
    }
    
    private var sections: [Tasks.List.ViewModel.Section] {
        return source?.sections ?? []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(forIndexPath: indexPath) as TaskTableViewCell
        guard let task = source?.taskAtIndexPath(indexPath) else {
            return cell
        }
        let model = TaskTableViewCellModel(title: task.title, subtitle: task.completedDate, showTick: task.isCompleted)
        cell.displayModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let source = source else {
            return
        }
        source.moveTask(from: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

}
