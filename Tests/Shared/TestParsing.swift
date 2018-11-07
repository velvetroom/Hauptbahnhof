import XCTest
@testable import Editor

class TestParsing:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        Factory.bundle = Bundle(for:TestParsing.self)
        master = GameMaster()
    }
    
    func testLoadGame() {
        XCTAssertFalse(master.game.title.isEmpty)
        XCTAssertFalse(master.game.messages.isEmpty)
        XCTAssertEqual(master.game.messages["initial"]!.text, master.message.text)
        XCTAssertFalse(master.message.text.isEmpty)
        XCTAssertFalse(master.message.options.isEmpty)
        XCTAssertFalse(master.message.options.first!.text.isEmpty)
        XCTAssertFalse(master.message.options.first!.next.isEmpty)
        XCTAssertNotNil(master.message.options.first!.effects)
    }
    
    func testPlayer() {
        XCTAssertFalse(master.player.chapter.isEmpty)
        XCTAssertFalse(master.player.state.isEmpty)
    }
}
