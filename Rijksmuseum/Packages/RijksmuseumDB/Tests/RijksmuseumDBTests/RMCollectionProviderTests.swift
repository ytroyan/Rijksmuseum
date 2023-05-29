import XCTest
@testable import RijksmuseumDB

final class RMCollectionProviderTests: XCTestCase {
    
    var settings: RMSettings!
    
    
    override func setUpWithError() throws {
        self.settings = RMSettings(apiKey: "test", language: .nl)
    }
    
    override func tearDownWithError() throws {
        self.settings = nil
    }
    
    func testGetCollectionError() async throws {
        let sut = RMCollectionProvider.init(settings: settings, offset: 10)
        do {
            let object = try await sut.getCollection()
            XCTFail("it should throws error")
        } catch {
            let networkError: NetworkError? = error as? NetworkError
            XCTAssertEqual(networkError?.description, "An unexpected error occurred code 401")
            XCTAssertEqual(networkError?.localizedDescription, "An unexpected error occurred code 401")
        }
    }
    
    func testGetCollectionSuccess() async throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let mockURLSession = URLSession(configuration: configuration)
        
        let object = RMArtObject(id: "test", objectNumber: "test", title: "", webImage: nil, headerImage: nil)
        let arrayOfObjects: [RMArtObject] = [object]
        let response = CollectionResponse(count: 1, artObjects: arrayOfObjects)
        let encoder = JSONEncoder()
        let data = try! encoder.encode(response)
        MockURLProtocol.mockData["/api/nl/collection?key=test&ps=10&p=10&s=artist"] = data
        
        let sut = RMCollectionProvider.init(settings: settings, offset: 10, urlSession: mockURLSession)
        let artObjects = try await sut.getCollection()
        XCTAssertEqual(artObjects.count, 1)
    }
}

