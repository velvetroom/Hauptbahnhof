import XCTest
@testable import Hauptbahnhof

class TestDelete:XCTestCase {
    private var workshop:Workshop!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
    }
    
    func testMessage() {
        workshop.game.messages["a"] = Message()
        workshop.deleteMessage("a")
        XCTAssertNil(workshop.game.messages["a"])
    }
}
