import Foundation
import UIKit

struct ThingDetailsViewModel: Equatable {
    let imageUrlString: String?
}

final class ThingDetailsView: UIView {
    private let imageProvider: ImageProviderService
    private let imageView = UIImageView()
    
    var onLikeButtonAction: (() -> Void)?
    var onDisLikeButtonAction: (() -> Void)?
    
    init(
        imageProvider: ImageProviderService = ImageProvider()
    ) {
        self.imageProvider = imageProvider
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    func setupUI() {
        setupImageView()
        setupButtons()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        let imageSize = 300.0
        imageView.pin(.top, to: .top, of: self, constant: 70)
        imageView.pinSize(imageSize)
        imageView.pin(.centerX, to: .centerX, of: self)
    }
    
    func setupButtons() {
        let buttonsSpacing = 10.0
        let buttonSize = 50.0

        let buttonsContainerStackView = UIStackView()
        buttonsContainerStackView.axis = .horizontal
        buttonsContainerStackView.alignment = .fill
        buttonsContainerStackView.distribution = .fillEqually
        buttonsContainerStackView.spacing = buttonsSpacing
        addSubview(buttonsContainerStackView)

        let likeButton = UIButton()
        likeButton.setImage(.likeImage, for: .normal)
        buttonsContainerStackView.addArrangedSubview(likeButton)

        let dislikeButton = UIButton()
        dislikeButton.setImage(.dislikeImage, for: .normal)
        buttonsContainerStackView.addArrangedSubview(dislikeButton)
        
        buttonsContainerStackView.pin(.top, to: .bottom, of: imageView, constant: 30)
        buttonsContainerStackView.pin(.centerX, to: .centerX, of: self)
        likeButton.pinSize(buttonSize)
        
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
    
    @objc
    func didTapLikeButton() {
        onLikeButtonAction?()
    }
    
    @objc
    func didTapDislikeButton() {
        onDisLikeButtonAction?()
    }
}
