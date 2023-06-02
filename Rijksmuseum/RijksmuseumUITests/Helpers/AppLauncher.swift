//
//  AppLauncher.swift
//  RijksmuseumUITests
//
//  Created by Troian on 01.06.2023.
//

import Foundation
import XCTest

protocol AppLauncher {
    var app: XCUIApplication {get}
    func launch() -> Self
}

extension AppLauncher {
    var app: XCUIApplication {
        XCUIApplication()
    }
    
    @discardableResult
    func launch() -> Self {
        app.launch()
        return self
    }
}
