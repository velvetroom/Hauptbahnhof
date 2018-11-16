import XCTest
@testable import Hauptbahnhof

class TestPlayer:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
    
    func testRestart() {
        master.player.score = 100
        master.restart()
        XCTAssertEqual(0, master.player.score)
    }
}
