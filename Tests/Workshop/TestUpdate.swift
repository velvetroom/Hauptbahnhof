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
    
    func testNext() {
        let option = Option()
        workshop.game.messages["a"] = Message()
        workshop.game.messages["a"]!.options = [option]
        workshop.update(option, next:"b")
        XCTAssertEqual("b", workshop.game.messages["a"]!.options.first!.next)
    }
}
