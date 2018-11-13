import XCTest
@testable import Hauptbahnhof

class TestSelection:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
    
    func testSelectChangesState() {
        let message = Message()
        let option = Option()
        message.text = "lorem ipsum"
        option.next = "hello world"
        master.game.messages = ["hello world":message]
        master.select(option)
        XCTAssertEqual("lorem ipsum", master.message.text)
    }
}
