//
//  ImageProviderServiceMock.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

@testable import RecrutDemo

final class ImageProviderServiceMock: ImageProviderService {

    var imageAsyncFromCompletionCallsCount = 0
    var imageAsyncFromCompletionReceivedUrlString: [String] = []
    var imageAsyncFromCompletionReceivedCompletion: [DownloadCompletion] = []

    func imageAsync(from urlString: String, completion: DownloadCompletion) {
        imageAsyncFromCompletionCallsCount += 1
        imageAsyncFromCompletionReceivedUrlString.append(urlString)
        imageAsyncFromCompletionReceivedCompletion.append(completion)
    }
}
