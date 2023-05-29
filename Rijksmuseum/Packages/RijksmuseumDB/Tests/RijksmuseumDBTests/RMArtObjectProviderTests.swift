//
//  RMArtObjectProviderTests.swift
//  
//
//  Created by Troian on 29.05.2023.
//

import XCTest
@testable import RijksmuseumDB

final class RMArtObjectProviderTests: XCTestCase {

    var settings: RMSettings!
    
    
    override func setUpWithError() throws {
        self.settings = RMSettings(apiKey: "test", language: .nl)
    }
    
    override func tearDownWithError() throws {
        self.settings = nil
    }
    
    func testGetArtObjectError() async throws {
        let sut = RMArtObjectProvider(settings: settings)
        
        do {
            _ = try await sut.detailArtObject(for: "BK-AM-33-J")
            XCTFail("it should throws error")
        } catch {
            let networkError: NetworkError? = error as? NetworkError
            XCTAssertEqual(networkError?.description, "An unexpected error occurred code 401")
            XCTAssertEqual(networkError?.localizedDescription, "An unexpected error occurred code 401")
        }
    }
    
    func testGetArtObjectSuccess() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        let sut = RMArtObjectProvider(settings: settings, urlSession: mockURLSession)
        let url = try XCTUnwrap(Bundle.module.url(forResource: "DetailArtObject", withExtension: "json"))
        let jsonData = try XCTUnwrap(Data(contentsOf: url))
  
        MockURLProtocol.mockData["/api/nl/collection/BK-AM-33-J?key=test"] = jsonData
        
        let artObject = try await sut.detailArtObject(for: "BK-AM-33-J")
        XCTAssertEqual(artObject.objectNumber, "BK-AM-33-J")
    }

}
