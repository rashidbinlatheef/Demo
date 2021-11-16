//
//  NetworkServiceMock.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

@testable import RecrutDemo

final class NetworkServiceMock: NetworkService {
    var executeRequestWithUrlStringMethodCompletionCallsCount = 0
    var executeRequestWithUrlStringMethodCompletionReceivedUrlString: [String] = []
    var executeRequestWithUrlStringMethodCompletionReceivedMethod: [RequestMethod] = []
    var executeRequestWithUrlStringMethodCompletionReceivedCompletion: [NetworkTaskCompletion] = []

    func executeRequestWith(urlString: String, method: RequestMethod, completion: @escaping NetworkTaskCompletion) {
        executeRequestWithUrlStringMethodCompletionCallsCount += 1
        executeRequestWithUrlStringMethodCompletionReceivedUrlString.append(urlString)
        executeRequestWithUrlStringMethodCompletionReceivedMethod.append(method)
        executeRequestWithUrlStringMethodCompletionReceivedCompletion.append(completion)
    }
}
