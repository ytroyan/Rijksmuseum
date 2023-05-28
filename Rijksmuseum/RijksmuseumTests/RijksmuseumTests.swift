//
//  RijksmuseumTests.swift
//  RijksmuseumTests
//
//  Created by Troian on 28.05.2023.
//

import XCTest
@testable import Rijksmuseum


final class RijksmuseumTests: XCTestCase {
    
    var sut: RMCollection!
    var settings: RMSettings!

    override func setUpWithError() throws {
        self.settings = RMSettings(apiKey: "0fiuZFh4", language: "nl")
        self.sut = RMCollection.init(settings: settings, offset: 10)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.settings = nil
    }

    func testGetCollection() async throws {
        let artObjects = try await sut.getCollection()
        XCTAssertEqual(artObjects.count, 10)
    }
    
//    func testGetCollectionObject() async throws {
//        let sut = CollectionObjectEndpoint(objectNumber: "RP-P-OB-87.351")
//        let response = try await session.getRequest(sut)
//        XCTAssertNotNil(response)
//    }
}
