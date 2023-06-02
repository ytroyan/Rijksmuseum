//
//  Navigation.swift
//  RijksmuseumUITests
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import XCTest

protocol Navigation: AppLauncher {
    var backButton: XCUIElement { get }
}


extension Navigation {
    var backButton: XCUIElement {
        app.buttons[""].firstMatch
    }
}

protocol NavigationActions: Navigation {
    func tapBackButton() -> Self
}

extension NavigationActions {
    @discardableResult
    func tapBackButton() -> Self {
        backButton.tap()
        return self
    }
}
