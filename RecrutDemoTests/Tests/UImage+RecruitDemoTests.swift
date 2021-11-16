//
//  UImage+RecruitDemoTests.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import XCTest
@testable import RecrutDemo

final class UImageRecruitDemoTests: XCTestCase {

    func testImages() {
        let images: [UIImage] = [
            .likeImage,
            .dislikeImage
        ]
        for image in images {
            XCTAssertNotNil(image)
        }
    }
}
