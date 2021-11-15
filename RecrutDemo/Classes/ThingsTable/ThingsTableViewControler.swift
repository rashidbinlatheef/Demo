import Foundation
import UIKit

final class ThingsTableViewControler: UITableViewController {
    
    struct TableViewConstants {
        static let cellIdentifier = "Cell"
        static let estimatedRowHeight: CGFloat = 180
    }
    
    var viewModel = ThingsTableViewModel()
    let notificationObserver = NotificationCenter.default
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        notificationObserver.addObserver(
            self,
            selector: #selector(didUpdateThingsModels(notification:)),
            name: ThingsModelUpdateNotification,
            object: nil
        )
    }
    
    @objc
    func didUpdateThingsModels(notification: NSNotification) {
        guard let thingModel = notification.object as? ThingModel,
                let itemIndex = viewModel.indexOf(thingModel),
                let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
        }
        let indexPath = IndexPath(item: itemIndex, section: 0)
        if visibleRowsIndexPaths.contains(indexPath) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ThingCell.self, forCellReuseIdentifier: TableViewConstants.cellIdentifier)
        tableView.estimatedRowHeight = TableViewConstants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.black
        tableView.separatorStyle = .singleLine
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasourceCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ThingCell = tableView.dequeueReusableCell(withIdentifier: TableViewConstants.cellIdentifier, for: indexPath) as? ThingCell else {
            fatalError("Couldn't dequeue cell of type: \(ThingCell.self) with identifier \(TableViewConstants.cellIdentifier). You probably forgot to register the table view cell class.")
        }
                
        let thingCellViewModel = viewModel.thingsCellViewModel(for: indexPath)
        cell.render(viewModel: thingCellViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let thingModel = viewModel.thing(for: indexPath)
        pushDetailsViewController(thingModel)
    }
    
    func pushDetailsViewController(_ thingModel: ThingModel) {
        let detailsViewController = ThingDetailsViewController()
        detailsViewController.thingModel = thingModel
        detailsViewController.imageProvider = viewModel.imageProvider
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
