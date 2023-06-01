//
//  ColectionViewInteractorTests.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import XCTest
//@testable import Rijksmuseum
import RijksmuseumDB
import Rijksmuseum

final class ColectionViewInteractorTests: XCTestCase {
    
    var sut: ColectionViewInteractor!
    var mockPresenter: MockCollectionViewPresenting!
    var mockProvider: MockCollectionProviding!
    var mockImageProvider: MockImageProviding!
    
    override func setUpWithError() throws {
        mockPresenter = MockCollectionViewPresenting()
        mockProvider = MockCollectionProviding()
        mockImageProvider = MockImageProviding()
        
        sut = ColectionViewInteractor(presenter: mockPresenter,
                                      provider: mockProvider,
                                      imageProvider: mockImageProvider)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testViewDidLoadFail() async throws {
        sut.viewDidLoad()
    
        let expectation = XCTestExpectation(description: "expectation")
        
        mockPresenter.notFoundHandler = {
            XCTAssertTrue(self.mockPresenter.isStarted)
            XCTAssertTrue(self.mockPresenter.isLoading)
            XCTAssertFalse(self.mockPresenter.isUpdated)
            XCTAssertTrue(self.mockPresenter.isNotFound)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }
    
    func testViewDidLoadSuccess() throws {
        mockProvider.collection = [ArtObject(id: "testId",
                                             objectNumber: "testId",
                                             title: "test title",
                                             principalOrFirstMaker: "Incredible Hulk")]
        sut.viewDidLoad()
        
        let expectation = XCTestExpectation(description: "expectation")

        mockPresenter.updatedHandler = {
            XCTAssertFalse(self.sut.items.isEmpty)
            XCTAssertTrue(self.mockPresenter.isStarted)
            XCTAssertTrue(self.mockPresenter.isLoading)
            XCTAssertTrue(self.mockPresenter.isUpdated)
            XCTAssertFalse(self.mockPresenter.isNotFound)
            expectation.fulfill()
        }
        
       wait(for: [expectation], timeout: 1)
    }
}

