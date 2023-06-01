import XCTest
@testable import ImageStorage

final class ImageStorageTests: XCTestCase {
    let sut = ImageStorage()
    let key = "test"
    
    override func setUpWithError() throws {
        sut.removeAll()
    }
    
    override func tearDownWithError() throws {
        sut.removeAll()
    }
    
    func testSaveData() throws {
        guard #available(iOS 13.0, *) else {
            throw XCTSkip("This test is designed for newest iOS api only.")
        }
        //given
        let givenObject = try XCTUnwrap(UIImage(systemName: "multiply.circle.fill"))
        let object = sut.loadImage(for: key)
        XCTAssertNil(object)
        //when
        sut.save(givenObject, for: key)
        //then
        let loadedObject = sut.loadImage(for: key)
        XCTAssertNotNil(loadedObject)
    }
}
