//
//  ImageProviderTests.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import XCTest
@testable import RecrutDemo

final class ImageProviderTests: XCTestCase {
    private var sut: ImageProvider!
    private var networkService: NetworkServiceMock!
    private var imageCache: ImageCacheServiceMock!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceMock()
        imageCache = ImageCacheServiceMock()
        sut = ImageProvider(
            networkService: networkService,
            cache: imageCache
        )
    }
    
    override func tearDown() {
        defer { super.tearDown() }
        networkService = nil
        imageCache = nil
        sut = nil
    }
    
    func testImageAsyncNotCachedImage() {
        // Given
        let urlString = "www.google.com"
    
        // When
        sut.imageAsync(from: urlString, completion: { _, _ in
            // Then
            XCTAssertEqual(self.networkService.executeRequestWithUrlStringMethodCompletionCallsCount, 1)
            XCTAssertEqual(self.networkService.executeRequestWithUrlStringMethodCompletionReceivedUrlString[0], urlString)
        })
    }
    
    func testImageAsyncWithCachedImage() {
        // Given
        let image = UIImage.dislikeImage
        let urlString = "www.google.com"
        imageCache.imageForKeyReturnValue = image
        
        // When
        sut.imageAsync(from: urlString, completion: { _, _ in
        })
        
        // Then
        XCTAssertEqual(imageCache.imageForKeyCallsCount, 1)
        XCTAssertEqual(imageCache.imageForKeyReceivedKey[0], urlString)
    }
}
