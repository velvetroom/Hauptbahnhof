import XCTest
@testable import Hauptbahnhof

class TestStorage_GameMaster:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        let data = try! Data(contentsOf:Bundle(for:TestStorage_GameMaster.self).url(forResource:"One", withExtension:"json")!)
        MockStorage.game = try! JSONDecoder().decode(Game.self, from:data)
        master = GameMaster()
    }
    
    override func tearDown() {
        MockStorage.onLoadPlayer = nil
        MockStorage.onSavePlayer = nil
        MockStorage.onLoadGame = nil
        MockStorage.game = Game()
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
}
