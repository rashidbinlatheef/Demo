//
//  ThingsTableViewModelTests.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import XCTest
@testable import RecrutDemo

final class ThingsTableViewModelTests: XCTestCase {
    private var sut: ThingsTableViewModel!
    private var things: ThingsTableViewModel!

    override func tearDown() {
        defer { super.tearDown() }
        sut = nil
        things = nil
    }
    
    func testThingsViewModel() {
        let thingsModelOne = ThingModel.generate(name: "name 1", uuid: "1")
        let thingsModelTwo = ThingModel.generate(name: "name 2", uuid: "2")
        let thingsModelThree = ThingModel.generate(name: "name 3", uuid: "3")

        sut = ThingsTableViewModel(
            things: [
                thingsModelOne,
                thingsModelTwo,
                thingsModelThree
            ]
        )
        
        XCTAssertEqual(sut.datasourceCount, 3)
        XCTAssertEqual(sut.indexOf(thingsModelOne), 0)
        XCTAssertTrue(sut.thing(for: IndexPath(row: 1, section: 0)) === thingsModelTwo)
    }
}
