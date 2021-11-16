import Foundation
import UIKit

struct ThingDetailsVCViewModel: Equatable {
    let title: String
}

final class ThingDetailsViewController: UIViewController {
    private let baseView = ThingDetailsView()
    private let thingModel: ThingModel!
    private let thingViewModelBuilder: ThingViewModelBuilding

    init(
        thingModel: ThingModel,
        thingViewModelBuilder: ThingViewModelBuilding
    ) {
        self.thingModel = thingModel
        self.thingViewModelBuilder = thingViewModelBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = baseView
        view.backgroundColor = UIColor.white
        baseView.render(
            viewModel: thingViewModelBuilder.buildThingDetailsViewModel(
                thingsModel: thingModel
            )
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let viewModel = thingViewModelBuilder.buildThingDetailsVCViewModel(
            thingsModel: thingModel
        )
        render(viewModel: viewModel)
    }
}

// MARK: - Private

private extension ThingDetailsViewController {
    func setupUI() {
        navigationController?.isNavigationBarHidden = false
        baseView.onLikeButtonAction = { [weak self] in
            self?.didTapLikeButton()
        }
        
        baseView.onDisLikeButtonAction = { [weak self] in
            self?.didTapDislikeButton()
        }
    }
    
    func render(viewModel: ThingDetailsVCViewModel) {
        title = viewModel.title
    }
    
    func didTapLikeButton() {
        thingModel.like = true
        NotificationCenter.default.post(
            name: ThingsModelUpdateNotification,
            object: thingModel
        )
        navigationController?.popViewController(animated: true)
    }
    
    func didTapDislikeButton() {
        thingModel.like = false
        NotificationCenter.default.post(
            name: ThingsModelUpdateNotification,
            object: thingModel
        )
        navigationController?.popViewController(animated: true)
    }
}
