import Foundation
import UIKit

struct ThingCellViewModel: Equatable {
    let name: String
    let imageUrlString: String?
    let likeImage: UIImage?
}

final class ThingCell: UITableViewCell {
    private let thingImage = UIImageView()
    private let likeImage = UIImageView()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }()
    
    private var imageProvider: ImageProviderService?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thingImage.layer.removeAllAnimations()
        likeImage.layer.removeAllAnimations()
        thingImage.image = nil
        likeImage.image = nil
        nameLabel.text = nil
        imageProvider = nil
    }
    
    func render(viewModel: ThingCellViewModel) {
        nameLabel.text = viewModel.name
        change(image: viewModel.likeImage, in: likeImage)
        imageProvider = ImageProvider()
        if let imageUrlString = viewModel.imageUrlString {
            imageProvider?.imageAsync(from: imageUrlString) { [weak self] image, urlString in
                guard let self = self else {
                    return
                }
                self.change(image: image, in: self.thingImage)
            }
        } else {
            change(image: nil, in: thingImage)
        }        
    }
}

// MARK: - Private Methods

private extension ThingCell {
    func setupUI() {
        contentView.backgroundColor = UIColor.clear
        setupBackgroundView()
        setupThingImageView()
        setupNameLabel()
        setupLikeImage()
        addShadow()
    }
    
    func setupBackgroundView() {
        let background = UIView()
        contentView.addSubview(background)
        
        background.pin(.leading, to: .leading, of: contentView)
        background.pin(.trailing, to: .trailing, of: contentView)
        background.pin(.top, to: .top, of: contentView)
        background.pin(.bottom, to: .bottom, of: contentView)

        background.backgroundColor = UIColor(white: 0.9, alpha: 0.1)
    }
    
    func setupThingImageView() {
        contentView.addSubview(thingImage)
        
        thingImage.pin(.leading, to: .leading, of: contentView, constant: 10)
        thingImage.pin(.top, to: .top, of: contentView, relatedBy:.greaterThanOrEqual, constant: 5)
        thingImage.pin(.centerY, to: .centerY, of: contentView)
        thingImage.pinSize(50)
        
        thingImage.backgroundColor = UIColor.clear
        thingImage.layer.masksToBounds = true
        thingImage.layer.cornerRadius = 10.0
        thingImage.contentMode = .scaleAspectFill
    }
    
    func setupNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.pin(.leading, to: .trailing, of: thingImage, constant: 5)
        nameLabel.pin(.centerY, to: .centerY, of: contentView)
        nameLabel.pin(.top, to: .top, of: contentView, relatedBy:.greaterThanOrEqual, constant: 5)
        nameLabel.numberOfLines = 0
    }
    
    func setupLikeImage() {
        contentView.addSubview(likeImage)
        likeImage.pin(.leading, to: .trailing, of: nameLabel, constant: 5)
        likeImage.pin(.centerY, to: .centerY, of: contentView)
        likeImage.pin(.trailing, to: .trailing, of: contentView, constant: -10)
        likeImage.pinSize(40)
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.0

        thingImage.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
        thingImage.layer.shadowOpacity = 0.3
        thingImage.layer.shadowRadius = 2.0
    }
    
    func change(image: UIImage?, in imageView: UIImageView, animated: Bool = true) {
        guard let image = image else {
            imageView.image = nil
            return
        }
        let transition = CATransition()
        transition.duration = 0.8
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        transition.type = CATransitionType.fade
    
        imageView.image = image
        imageView.layer.add(transition, forKey: nil)
    }
}
