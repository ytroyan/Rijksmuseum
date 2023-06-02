//
//  DetailScreen.swift
//  RijksmuseumUITests
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import XCTest

protocol DetailScreen: AppLauncher {
    var openButton: XCUIElement { get }
}

extension DetailScreen {
    var openButton: XCUIElement {
        app.buttons["DetailArtObject.openButton"].firstMatch
    }
}

protocol DetailScreenActions: DetailScreen {
    func tapOpenButton() -> Self
    func waitForOpenButtonAppears() -> Self
}

extension DetailScreenActions {
    @discardableResult
    func tapOpenButton() -> Self {
        openButton.tap()
        return self
    }
    
    @discardableResult
    func waitForOpenButtonAppears() -> Self {
        XCTAssertTrue(openButton.waitForExistence(timeout: 5))
        return self
    }
}
