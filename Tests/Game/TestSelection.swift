import XCTest
@testable import Hauptbahnhof

class TestSelection:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
    
    func testChangesState() {
        let message = Message()
        let option = Option()
        message.text = "lorem ipsum"
        option.next = "hello world"
        master.game.messages = ["hello world":message]
        master.select(option)
        XCTAssertEqual("lorem ipsum", master.message.text)
    }
    
    func testUpdatesTimeStamp() {
        XCTAssertEqual(0, master.player.syncstamp)
        let date = Date().timeIntervalSince1970
        master.select(Option())
        XCTAssertLessThanOrEqual(date, master.player.syncstamp)
    }
}
