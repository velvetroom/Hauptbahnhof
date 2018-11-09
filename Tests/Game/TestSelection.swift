import XCTest
@testable import Hauptbahnhof

class TestSelection:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        let data = try! Data(contentsOf:Bundle(for:TestSelection.self).url(forResource:"One", withExtension:"json")!)
        MockStorage.game = try! JSONDecoder().decode(Game.self, from:data)
        master = GameMaster()
    }
    
    override func tearDown() {
        MockStorage.game = Game()
    }
    
    func testSelectChangesState() {
        
    }
}
