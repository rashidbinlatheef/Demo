import Foundation
import UIKit

struct ThingDetailsViewModel {
    let imageUrlString: String?
}

final class ThingDetailsView: UIView {
    private let imageProvider: ImageProvider
    private let imageView = UIImageView()
    private let buttons = UIStackView()
    private let likeButton = UIButton()
    private let dislikeButton = UIButton()
    
    var onLikeButtonAction: (() -> Void)?
    var onDisLikeButtonAction: (() -> Void)?

    init(
        imageProvider: ImageProvider = ImageProvider()
    ) {
        self.imageProvider = imageProvider
        super.init(frame: CGRect.zero)
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        likeButton.setImage(.likeImage, for: .normal)
        //addSubview(likeButton)
        
        dislikeButton.setImage(.dislikeImage, for: .normal)
        //addSubview(dislikeButton)
        
        buttons.addArrangedSubview(likeButton)
        buttons.addArrangedSubview(dislikeButton)
        
        buttons.axis = .horizontal
        buttons.alignment = .center
        buttons.distribution = .equalSpacing
        buttons.spacing = 10.0
        addSubview(buttons)
        
        setNeedsUpdateConstraints()
        
        likeButton.addTarget(
            self,
            action: #selector(didTapLikeButton),
            for: .touchUpInside
        )
        
        dislikeButton.addTarget(
            self,
            action: #selector(didTapDislikeButton),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    func render(viewModel: ThingDetailsViewModel) {
        if let urlString = viewModel.imageUrlString {
            imageProvider.imageAsync(
                from: urlString,
                completion: { [weak self] image, imageUrl in
                    self?.imageView.image = image
                }
            )
        }
    }
}

// MARK: - Private

private extension ThingDetailsView {
    @objc
    func didTapLikeButton() {
        onLikeButtonAction?()
    }
    
    @objc
    func didTapDislikeButton() {
        onDisLikeButtonAction?()
    }
    
    func setupConstraints() {
       imageView.translatesAutoresizingMaskIntoConstraints = false
       likeButton.translatesAutoresizingMaskIntoConstraints = false
       dislikeButton.translatesAutoresizingMaskIntoConstraints = false
       buttons.translatesAutoresizingMaskIntoConstraints = false
       
       let padding: CGFloat = 20.0
       let imageSize: CGFloat = 300.0
       imageView.topAnchor.constraint(equalTo: topAnchor, constant: 70.0).isActive = true
       imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
       imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
       imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
       imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
       
       let buttonSize: CGFloat = 50.0
       buttons.widthAnchor.constraint(equalToConstant: 120).isActive = true
       likeButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
       likeButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
       
       dislikeButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
       dislikeButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
       
       buttons.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
       buttons.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0).isActive = true
   }
}
