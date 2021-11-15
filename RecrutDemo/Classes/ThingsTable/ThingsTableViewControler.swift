import Foundation
import UIKit

final class ThingsTableViewControler: UITableViewController {
    private struct TableViewConstants {
        static let cellIdentifier = "Cell"
        static let estimatedRowHeight: CGFloat = 180
    }
    
    private let viewModel = ThingsTableViewModel()
    private let notificationObserver = NotificationCenter.default
    private let thingViewModelBuilder: ThingViewModelBuilding

    init(
        thingViewModelBuilder: ThingViewModelBuilding = ThingViewModelBuilder()
    ) {
        self.thingViewModelBuilder = thingViewModelBuilder
        super.init(nibName: nil, bundle: nil)
        notificationObserver.addObserver(
            self,
            selector: #selector(didUpdateThingsModels(notification:)),
            name: ThingsModelUpdateNotification,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ThingsTableViewControler {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasourceCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ThingCell = tableView.dequeueReusableCell(withIdentifier: TableViewConstants.cellIdentifier, for: indexPath) as? ThingCell else {
            fatalError("Couldn't dequeue cell of type: \(ThingCell.self) with identifier \(TableViewConstants.cellIdentifier). You probably forgot to register the table view cell class.")
        }
        let thingsModel = viewModel.thing(for: indexPath)
        let thingCellViewModel = thingViewModelBuilder.buildThingCellViewModel(
            thingsModel: thingsModel
        )
        cell.render(viewModel: thingCellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let thingModel = viewModel.thing(for: indexPath)
        pushDetailsViewController(thingModel)
    }
}

// MARK: - Private

private extension ThingsTableViewControler {
    func configureTableView() {
        tableView.register(ThingCell.self, forCellReuseIdentifier: TableViewConstants.cellIdentifier)
        tableView.estimatedRowHeight = TableViewConstants.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.black
        tableView.separatorStyle = .singleLine
    }
    
    func pushDetailsViewController(_ thingModel: ThingModel) {
        let detailsViewController = ThingDetailsViewController(
            thingModel: thingModel,
            thingViewModelBuilder: thingViewModelBuilder
        )
        navigationController?.pushViewController(detailsViewController, animated: true)
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
}

