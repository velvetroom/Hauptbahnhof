import XCTest
@testable import Hauptbahnhof

class TestEffects:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
    
    func testIncreaseScore2() {
        let option = Option()
        option.effects = [.increaseScore2]
        master.select(option)
        XCTAssertEqual(2, master.player.score)
    }
    
    func testIncreaseScore10() {
        let option = Option()
        option.effects = [.increaseScore10]
        master.select(option)
        XCTAssertEqual(10, master.player.score)
    }
    
    func testIncreaseCourage() {
        let option = Option()
        option.effects = [.increaseCourage]
        master.select(option)
        XCTAssertEqual(1, master.player.courage)
    }
    
    func testMaxCourage() {
        let option = Option()
        option.effects = [.increaseCourage]
        master.player.courage = 100
        master.select(option)
        XCTAssertEqual(100, master.player.courage)
    }
    
    func testIncreaseEmpathy() {
        let option = Option()
        option.effects = [.increaseEmpathy]
        master.select(option)
        XCTAssertEqual(1, master.player.empathty)
    }
    
    func testMaxEmpathy() {
        let option = Option()
        option.effects = [.increaseEmpathy]
        master.player.empathty = 100
        master.select(option)
        XCTAssertEqual(100, master.player.empathty)
    }
    
    func testIncreaseDiligence() {
        let option = Option()
        option.effects = [.increaseDiligence]
        master.select(option)
        XCTAssertEqual(1, master.player.diligence)
    }
    
    func testMaxDiligence() {
        let option = Option()
        option.effects = [.increaseDiligence]
        master.player.diligence = 100
        master.select(option)
        XCTAssertEqual(100, master.player.diligence)
    }
    
    func testIncreaseKnowledge() {
        let option = Option()
        option.effects = [.increaseKnowledge]
        master.select(option)
        XCTAssertEqual(1, master.player.knowledge)
    }
    
    func testMaxKnowledge() {
        let option = Option()
        option.effects = [.increaseKnowledge]
        master.player.knowledge = 100
        master.select(option)
        XCTAssertEqual(100, master.player.knowledge)
    }
}
