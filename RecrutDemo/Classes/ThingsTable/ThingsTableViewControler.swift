import Foundation
import UIKit

class ThingsTableViewControler: UITableViewController {
    
    struct TableViewConstants {
        
        static let cellIdentifier = "Cell"
        static let rowHeight: CGFloat = 60
        static let estimatedRowHeight: CGFloat = 180
    }
    
    var viewModel = ThingsTableViewModel()
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = TableViewConstants.estimatedRowHeight
        tableView.rowHeight = TableViewConstants.rowHeight
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
        
        var cell: ThingCell? = tableView.dequeueReusableCell(withIdentifier: TableViewConstants.cellIdentifier) as? ThingCell
        
        if cell == nil {
            cell = ThingCell()
        }
        viewModel.bindModelWithView(cell: cell!, at: indexPath)
        
        let thingModel = viewModel.thing(for: indexPath)
        cell?.update(withText: thingModel.name)
        cell?.update(withLikeValue: thingModel.like)
        
        if let urlString = thingModel.image {
            viewModel.imageProvider.imageAsync(from: urlString, completion: { (image, imageUrl) in
                cell?.updateThingImage(image)
            })
        }
        
        return cell!
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
        detailsViewController.delegate = self
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension ThingsTableViewControler: ThingDetailsDelegate {

    func thingDetails(viewController: ThingDetailsViewController, didLike thingModel: inout ThingModel) {
        
        thingModel.setLike(value: true)
        navigationController?.popToViewController(self, animated: true)
    }
    
    func thingDetails(viewController: ThingDetailsViewController, didDislike thingModel: inout ThingModel) {
        
        thingModel.setLike(value: false)
        navigationController?.popToViewController(self, animated: true)
    }
}






































































