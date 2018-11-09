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
}
