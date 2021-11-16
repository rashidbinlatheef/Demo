import Foundation
import UIKit

/// Provides Image caching services
protocol ImageCacheService {
    /// Stores Image in Cache
    /// - Parameters:
    ///   - image: The object to be stored in the cache.
    ///   - key: The key with which to associate the `image`.
    func storeImage(_ image: UIImage, key: String)
    
    /// Returns the image associated with a given key.
    /// - Parameters:
    ///   - key: An object identifying the value.
    func image(forKey key: String) -> UIImage?
}

final class ImageCache {
    static let sharedInstance = ImageCache()
    static private let imageCache = NSCache<NSString, UIImage>()

    private init() {}
}

extension ImageCache: ImageCacheService {
    func storeImage(_ image: UIImage, key: String) {
        Self.imageCache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        Self.imageCache.object(forKey: key as NSString)
    }
}
