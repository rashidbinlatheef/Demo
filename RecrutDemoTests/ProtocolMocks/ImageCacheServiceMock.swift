//
//  ImageCacheServiceMock.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

@testable import RecrutDemo
import UIKit

final class ImageCacheServiceMock: ImageCacheService {

    var storeImageKeyCallsCount = 0
    var storeImageKeyReceivedImage: [UIImage] = []
    var storeImageKeyReceivedKey: [String] = []
    var imageForKeyCallsCount = 0
    var imageForKeyReceivedKey: [String] = []
    var imageForKeyReturnValue: UIImage?

    func storeImage(_ image: UIImage, key: String) {
        storeImageKeyCallsCount += 1
        storeImageKeyReceivedImage.append(image)
        storeImageKeyReceivedKey.append(key)
    }

    func image(forKey key: String) -> UIImage? {
        imageForKeyCallsCount += 1
        imageForKeyReceivedKey.append(key)
        return imageForKeyReturnValue
    }
}
