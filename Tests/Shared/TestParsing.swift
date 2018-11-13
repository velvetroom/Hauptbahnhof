import XCTest
@testable import Hauptbahnhof

class TestParsing:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
        let data = try! Data(contentsOf:Bundle(for:TestParsing.self).url(forResource:"One", withExtension:"json")!)
        master.game = try! JSONDecoder().decode(Game.self, from:data)
    }
    
    func testLoadGame() {
        XCTAssertEqual(Chapter.One, master.game.chapter)
        XCTAssertEqual("Chapter One", master.game.title)
        XCTAssertFalse(master.game.messages.isEmpty)
        XCTAssertEqual(master.game.messages["initial"]!.text, master.message.text)
        XCTAssertFalse(master.message.text.isEmpty)
        XCTAssertFalse(master.message.options.isEmpty)
        XCTAssertFalse(master.message.options.first!.text.isEmpty)
        XCTAssertFalse(master.message.options.first!.next.isEmpty)
        XCTAssertNotNil(master.message.options.first!.effects)
    }
    
    func testPlayer() {
        XCTAssertEqual("One", master.player.chapter.rawValue)
        XCTAssertFalse(master.player.state.isEmpty)
    }
}
