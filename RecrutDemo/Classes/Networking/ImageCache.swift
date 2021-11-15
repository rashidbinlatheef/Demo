import Foundation
import UIKit

class ImageCache {
    
    let fileManager = FileManager.default
    let cachesPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    var cacheSize = 70
    
    private var localCache = Dictionary<String, UIImage>()
    private func moveImage(from: URL, to destinationURL: URL) -> String? {
        
        do {
            try self.fileManager.moveItem(at: from, to: destinationURL)
        }
        catch {
            
            let er = error as NSError
            if er.code == NSFileWriteFileExistsError {
              
                return destinationURL.path
            }
            debugPrint("Download image error \(error)")
            return nil
        }
        
        return destinationURL.path
    }
    
    private func save(image: UIImage, to destinationURL: URL) {
        
        do {
            
            let binaryData = image.pngData()
            try binaryData?.write(to: destinationURL, options: .atomicWrite)
        }
        catch {
            
            debugPrint("Saving image error \(error)")
            let er = error as NSError
            if er.code == NSFileWriteFileExistsError {
                
            }
        }
    }
    
    func imageName(for url: URL) -> String {
    
        var imageName = url.lastPathComponent
        if let size = url.query {
            imageName = imageName + size
        }
        return imageName
    }
    
    func destinationURL(for url: URL) -> URL {
        
        let imageName = self.imageName(for: url)
        return self.cachesPath.appendingPathComponent(imageName)
    }
    
    func destinationURL(for imageName: String) -> URL {
        
        return self.cachesPath.appendingPathComponent(imageName)
    }
    
    func storeImageLocally(image: UIImage, key: String) {
        localCache[key] = image//store in cache
    }
    
    func storeImageInCache(from location: URL, imageName: String) -> UIImage? {
        
        let destination = destinationURL(for: imageName)
        guard let imagePath = moveImage(from: location, to: destination) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}








