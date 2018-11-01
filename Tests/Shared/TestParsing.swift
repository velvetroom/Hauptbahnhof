import XCTest
@testable import Hauptbahnhof

class TestParsing:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
    
    func testLoadSource() {
        XCTAssertTrue(master.game.title.isEmpty)
        master.load(try! Data(contentsOf:Bundle(for:TestParsing.self).url(forResource:"One", withExtension:"json")!))
        XCTAssertFalse(master.game.title.isEmpty)
        XCTAssertFalse(master.game.messages.isEmpty)
        XCTAssertFalse(master.game.state.isEmpty)
        XCTAssertEqual(master.game.messages["initial"]!.text, master.message.text)
        XCTAssertFalse(master.message.text.isEmpty)
        XCTAssertFalse(master.message.options.isEmpty)
        XCTAssertFalse(master.message.options.first!.text.isEmpty)
        XCTAssertNotNil(master.message.options.first!.effects)
    }
}
