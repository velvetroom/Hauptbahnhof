import XCTest
@testable import Hauptbahnhof

class TestUpdate:XCTestCase {
    private var workshop:Workshop!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
    }
    
    func testMessageText() {
        workshop.game.messages["a"] = Message()
        workshop.update("a", text:"hello world")
        XCTAssertEqual("hello world", workshop.game.messages["a"]!.text)
    }
    
    func testOptionNext() {
        let option = Option()
        workshop.game.messages["a"] = Message()
        workshop.game.messages["a"]!.options = [option]
        workshop.update(option, next:"b")
        XCTAssertEqual("b", workshop.game.messages["a"]!.options.first!.next)
    }
    
    func testOptionText() {
        let option = Option()
        option.text = "hello world"
        workshop.game.messages["a"] = Message()
        workshop.game.messages["a"]!.options = [option]
        workshop.update(option, text:"lorem ipsum")
        XCTAssertEqual("lorem ipsum", workshop.game.messages["a"]!.options.first!.text)
    }
}
