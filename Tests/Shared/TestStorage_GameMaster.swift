import XCTest
@testable import Hauptbahnhof

class TestStorage_GameMaster:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
        let data = try! Data(contentsOf:Bundle(for:TestStorage_GameMaster.self).url(forResource:"Prologue", withExtension:"json")!)
        master.game = try! JSONDecoder().decode(Game.self, from:data)
    }
    
    override func tearDown() {
        MockStorage.onLoadPlayer = nil
        MockStorage.onLoadGame = nil
        MockStorage.onLoadBoard = nil
        MockStorage.onSavePlayer = nil
        MockStorage.onSaveBoard = nil
    }
    
    func testLoadsPlayer() {
        let expect = expectation(description:String())
        MockStorage.onLoadPlayer = { expect.fulfill() }
        let _ = GameMaster()
        waitForExpectations(timeout:1)
    }
    
    func testLoadsGame() {
        let expect = expectation(description:String())
        MockStorage.onLoadGame = { expect.fulfill() }
        let _ = GameMaster()
        waitForExpectations(timeout:1)
    }
    
    func testSelectSavesPlayer() {
        let expect = expectation(description:String())
        MockStorage.onSavePlayer = { expect.fulfill() }
        GameMaster().select(Option())
        waitForExpectations(timeout:1)
    }
    
    func testRestartSavesPlayer() {
        let expect = expectation(description:String())
        MockStorage.onSavePlayer = { expect.fulfill() }
        GameMaster().restart()
        waitForExpectations(timeout:1)
    }
    
    func testLoadsBoard() {
        let expect = expectation(description:String())
        MockStorage.onLoadBoard = { expect.fulfill() }
        let _ = GameMaster()
        waitForExpectations(timeout:1)
    }
    
    func testRateSavesBoard() {
        let expect = expectation(description:String())
        MockStorage.onSaveBoard = { expect.fulfill() }
        let _ = GameMaster().rate()
        waitForExpectations(timeout:1)
    }
}
