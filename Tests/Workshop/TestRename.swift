import XCTest
@testable import Hauptbahnhof

class TestRename:XCTestCase {
    private var workshop:Workshop!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
        workshop.game.messages["a"] = Message()
    }
    
    func testSuccess() {
        XCTAssertNoThrow(try workshop.rename("a", to:"b"))
    }
    
    func testEmpty() {
        XCTAssertThrowsError(try workshop.rename("a", to:""))
    }
    
    func testRepeated() {
        workshop.game.messages["b"] = Message()
        XCTAssertThrowsError(try workshop.rename("a", to:"b"))
    }
    
    func testCurrent() {
        XCTAssertNoThrow(try workshop.rename("a", to:"a"))
    }
}
