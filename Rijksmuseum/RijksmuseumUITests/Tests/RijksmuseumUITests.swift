//
//  RijksmuseumUITests.swift
//  RijksmuseumUITests
//
//  Created by Troian on 28.05.2023.
//

import XCTest

final class RijksmuseumUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testMainFlow() throws {
        MainFlow()
            .launch()
            .waitForFirstCellAppears()
            .tapFirstCell()
            .waitForOpenButtonAppears()
            .tapOpenButton()
    }
}
