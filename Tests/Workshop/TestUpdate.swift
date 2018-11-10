import XCTest
@testable import Hauptbahnhof

class TestUpdate:XCTestCase {
    private var workshop:Workshop!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
    }
    
    func testMessage() {
        workshop.game.messages["a"] = Message()
        workshop.update("a", text:"hello world")
        XCTAssertEqual("hello world", workshop.game.messages["a"]!.text)
    }
}
