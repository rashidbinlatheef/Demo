//
//  ThingViewModelBuilderTests.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import XCTest
@testable import RecrutDemo

final class ThingViewModelBuilderTests: XCTestCase {
    private var sut: ThingViewModelBuilder!

    override func setUp() {
        super.setUp()
        sut = ThingViewModelBuilder()
    }
    
    override func tearDown() {
        defer { super.tearDown() }
        sut = nil
    }

    func testBuildThingCellViewModelWithNilLike() {
        let name = "a name"
        let imageUrlString = "some url"
        
        let thingModel = ThingModel.generate(
            name: name,
            image: imageUrlString
        )
        
        let result = sut.buildThingCellViewModel(thingsModel: thingModel)
        
        XCTAssertEqual(result.name, name)
        XCTAssertEqual(result.imageUrlString, imageUrlString)
        XCTAssertNil(result.likeImage)
    }
    
    func testBuildThingCellViewModelWithLikeFalse() {
        let name = "a name"
        let imageUrlString = "some url"
        let expectedLikeImage = UIImage.dislikeImage
        
        let thingModel = ThingModel.generate(
            name: name,
            image: imageUrlString,
            like: false
        )
        
        let result = sut.buildThingCellViewModel(thingsModel: thingModel)
        
        XCTAssertEqual(result.name, name)
        XCTAssertEqual(result.imageUrlString, imageUrlString)
        XCTAssertEqual(result.likeImage, expectedLikeImage)
    }
    
    func testBuildThingCellViewModelWithLikeTrue() {
        let name = "a name"
        let imageUrlString = "some url"
        let expectedLikeImage = UIImage.likeImage
        
        let thingModel = ThingModel.generate(
            name: name,
            image: imageUrlString,
            like: true
        )
        
        let result = sut.buildThingCellViewModel(thingsModel: thingModel)
        
        XCTAssertEqual(result.name, name)
        XCTAssertEqual(result.imageUrlString, imageUrlString)
        XCTAssertEqual(result.likeImage, expectedLikeImage)
    }
    
    func testBuildThingDetailsVCViewModel() {
        let name = "a name"
        let thingModel = ThingModel.generate(
            name: name
        )
        
        let result = sut.buildThingDetailsVCViewModel(thingsModel: thingModel)
        XCTAssertEqual(result.title, name)
    }
    
    func testBuildThingDetailsViewModel() {
        let imageUrlString = "some url"
        let thingModel = ThingModel.generate(
            image: imageUrlString
        )
        
        let result = sut.buildThingDetailsViewModel(thingsModel: thingModel)
        XCTAssertEqual(result.imageUrlString, imageUrlString)
    }
}
