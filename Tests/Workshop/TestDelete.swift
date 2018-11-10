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
    
    func testUpdateNext() {
        workshop.game.messages["b"] = Message()
        workshop.game.messages["c"] = Message()
        let optionB0 = Option()
        optionB0.next = "a"
        let optionB1 = Option()
        optionB1.next = "c"
        let optionC0 = Option()
        optionC0.next = "a"
        workshop.game.messages["b"]!.options = [optionB0, optionB1]
        workshop.game.messages["c"]!.options = [optionC0]
        workshop.deleteMessage("a")
        XCTAssertEqual(String(), optionB0.next)
        XCTAssertEqual("c", optionB1.next)
        XCTAssertEqual(String(), optionC0.next)
    }
}
