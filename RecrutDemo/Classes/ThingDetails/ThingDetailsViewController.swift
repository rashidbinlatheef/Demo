import Foundation
import UIKit

class ThingDetailsViewController: UIViewController {
    
    private let baseView = ThingDetailsView()
    var thingModel: ThingModel!
    var imageProvider: ImageProvider!
    var delegate: ThingDetailsDelegate? = nil
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        
        view = baseView
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = thingModel.name
        
        baseView.likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        baseView.dislikeButton.addTarget(self, action: #selector(didTapDislikeButton), for: .touchUpInside)
        setup()
        displayImage()
    }
    
    @objc func didTapCloseButton() {
        delegate?.thingDetails(viewController: self, willDismiss: &thingModel!)
    }
    
    @objc func didTapLikeButton() {
        delegate?.thingDetails(viewController: self, didLike: &thingModel!)
    }
    @objc
    func didTapDislikeButton() {
        delegate?.thingDetails(viewController: self, didDislike: &thingModel!)
    }
    
    func displayImage() {
        
        if let urlString = thingModel.image {
            imageProvider.imageAsync(from: urlString, completion: { (image, imageUrl) in
                self.baseView.setThing(image: image)
            })
        }
    }
}



