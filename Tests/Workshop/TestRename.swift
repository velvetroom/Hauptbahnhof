import XCTest
@testable import Hauptbahnhof

class TestRename:XCTestCase {
    private var workshop:Workshop!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
        workshop.game.messages["a"] = Message()
        workshop.game.messages["a"]!.text = "hello world"
    }
    
    func testValidSuccess() {
        XCTAssertNoThrow(try workshop.validRename("a", to:"b"))
    }
    
    func testEmpty() {
        XCTAssertThrowsError(try workshop.validRename("a", to:""))
    }
    
    func testRepeated() {
        workshop.game.messages["b"] = Message()
        XCTAssertThrowsError(try workshop.validRename("a", to:"b"))
    }
    
    func testCurrent() {
        XCTAssertNoThrow(try workshop.validRename("a", to:"a"))
    }
    
    func testCaseInsensitive() {
        workshop.game.messages["b"] = Message()
        XCTAssertThrowsError(try workshop.validRename("a", to:"B"))
    }
    
    func testRename() {
        workshop.rename("a", to:"b")
        XCTAssertNil(workshop.game.messages["a"])
        XCTAssertNotNil(workshop.game.messages["b"])
        XCTAssertEqual("hello world", workshop.game.messages["b"]!.text)
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
        workshop.rename("a", to:"z")
        XCTAssertEqual("z", optionB0.next)
        XCTAssertEqual("c", optionB1.next)
        XCTAssertEqual("z", optionC0.next)
    }
}
