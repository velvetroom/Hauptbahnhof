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
    
    func testSavesOnRename() {
        let expect = expectation(description:String())
        MockStorage.onSaveGame = { expect.fulfill() }
        workshop.rename("", to:"")
        waitForExpectations(timeout:1)
    }
    
    func testSavesOnDelete() {
        let expect = expectation(description:String())
        MockStorage.onSaveGame = { expect.fulfill() }
        workshop.deleteMessage("")
        waitForExpectations(timeout:1)
    }
    
    func testSavesOnUpdateText() {
        let expect = expectation(description:String())
        workshop.game.messages["a"] = Message()
        MockStorage.onSaveGame = { expect.fulfill() }
        workshop.update("a", text:"hello world")
        waitForExpectations(timeout:1)
    }
    
    func testSavesOnUpdateNext() {
        let expect = expectation(description:String())
        MockStorage.onSaveGame = { expect.fulfill() }
        workshop.update(Option(), next:String())
        waitForExpectations(timeout:1)
    }
}
