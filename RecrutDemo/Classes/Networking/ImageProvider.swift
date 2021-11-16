import Foundation
import UIKit

typealias DownloadCompletion = ((_ image: UIImage?, _ urlString: String) -> ())?

/// Service which provides image
protocol ImageProviderService {
    /// Download images from a given url
    ///
    /// - Parameters:
    ///   - urlString: The url of the network request
    ///   - completion: The response in `DownloadCompletion`
    func imageAsync(from urlString: String, completion: DownloadCompletion)
}

final class ImageProvider {
    private let networkService: NetworkService
    private let cache: ImageCacheService
    private let queue = DispatchQueue(label: "imageDownloading")
    
    init(
        networkService: NetworkService = NetworkLayer.sharedInstance,
        cache: ImageCacheService = ImageCache.sharedInstance
    ) {
        self.networkService = networkService
        self.cache = cache
    }
}

// MARK: - ImageProviderService

extension ImageProvider: ImageProviderService {
    func imageAsync(from urlString: String, completion: DownloadCompletion) {
        if let cachedImage = cache.image(forKey: urlString) {
            DispatchQueue.main.async {
                completion?(cachedImage, urlString)
            }
        } else {
            queue.async { [weak self] in
                self?.networkService.executeRequestWith(urlString: urlString, method: .GET) { [weak self] _, _, data, error
                    in
                    if error != nil {
                        DispatchQueue.main.async {
                            completion?(nil, urlString)
                        }
                    } else if let imageData = data, let downloadedImage = UIImage(data: imageData) {
                        self?.cache.storeImage(downloadedImage, key: urlString)
                        DispatchQueue.main.async {
                            completion?(downloadedImage, urlString)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion?(nil, urlString)
                        }
                    }
                }
            }
        }
    }
}
