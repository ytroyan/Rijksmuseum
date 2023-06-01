//
//  ImageProviderTests.swift
//  RijksmuseumTests
//
//  Created by Troian on 01.06.2023.
//

import XCTest
@testable import Rijksmuseum
import ImageStorage


final class ImageProviderTests: XCTestCase {

    private var sut: ImageProvider!
      private var mockImageStorage = MockImageStorage()
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        sut = ImageProvider(storage: mockImageStorage, session: mockURLSession)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLoadFromStorage() async throws {
        XCTAssertNil(mockImageStorage.image)
        let image: UIImage = try XCTUnwrap(UIImage(systemName: "photo"))
        MockURLProtocol.mockData["/image"] = image.pngData()!
        let loadedImage = try await sut.loadImage(for: "https://testImageURL.com/image")
        XCTAssertNotNil(mockImageStorage.image)
        XCTAssertNotNil(loadedImage)
        mockImageStorage.saved = false
        let loadedImageFromStorage = try await sut.loadImage(for: "https://testImageURL.com/image")
        XCTAssertNotNil(mockImageStorage.image)
        XCTAssertNotNil(loadedImageFromStorage)
        XCTAssertEqual(mockImageStorage.saved, false)
    }
}
