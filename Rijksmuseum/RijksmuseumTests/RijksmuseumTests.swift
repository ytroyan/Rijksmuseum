//
//  RijksmuseumTests.swift
//  RijksmuseumTests
//
//  Created by Troian on 28.05.2023.
//

import XCTest
@testable import Rijksmuseum
import RijksmuseumDB

final class RijksmuseumTests: XCTestCase {
    
    var settings: RMSettings!

    override func setUpWithError() throws {
        self.settings = RMSettings(apiKey: "0fiuZFh4", language: "nl")
    }

    override func tearDownWithError() throws {
        self.settings = nil
    }

    func testGetCollection() async throws {
        let sut = RMCollection.init(settings: settings, offset: 10)
        let artObjects = try await sut.getCollection()
        XCTAssertEqual(artObjects.count, 10)
    }
    
    func testGetCollectionObject() async throws {
        let sut = RMArtObjectLoader(settings: settings)
        let response = try await sut.detailArtObject(for: "BK-AM-33-J")
        XCTAssertNotNil(response)
    }
}
