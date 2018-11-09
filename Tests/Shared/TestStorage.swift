import XCTest
@testable import Hauptbahnhof

class TestStorage:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        Factory.bundle = Bundle(for:TestParsing.self)
        let data = try! Data(contentsOf:Bundle(for:TestStorage.self).url(forResource:"One", withExtension:"json")!)
        MockStorage.game = try! JSONDecoder().decode(Game.self, from:data)
        master = GameMaster()
    }
    
    override func tearDown() {
        MockStorage.onLoadPlayer = nil
        MockStorage.onSavePlayer = nil
        MockStorage.onLoadGame = nil
    }
    
    func testMasterLoadsPlayer() {
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
