//
//  CollectionScreen.swift
//  RijksmuseumUITests
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import XCTest


protocol CollectionScreen: AppLauncher {
    var firstCell: XCUIElement { get }
}

extension CollectionScreen {
    var firstCell: XCUIElement {
        app.cells["collection.cell.0-1"].firstMatch
    }
}

protocol CollectionScreenActions: CollectionScreen {
    func tapFirstCell() -> Self
    func waitForFirstCellAppears() -> Self
}

extension CollectionScreenActions {
    @discardableResult
    func tapFirstCell() -> Self {
        firstCell.tap()
        return self
    }
    
    @discardableResult
    func waitForFirstCellAppears() -> Self {
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        return self
    }
}
