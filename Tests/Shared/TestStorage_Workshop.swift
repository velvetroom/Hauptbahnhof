import XCTest
@testable import Hauptbahnhof

class TestStorage_Workshop:XCTestCase {
    private var workshop:Workshop!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
    }
    
    override func tearDown() {
        MockStorage.onSaveGame = nil
    }
    
    func testSavesOnAddMessage() {
        let expect = expectation(description:String())
        MockStorage.onSaveGame = { expect.fulfill() }
        workshop.addMessage()
        waitForExpectations(timeout:1)
    }
}
