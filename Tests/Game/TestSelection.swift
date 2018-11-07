import XCTest
@testable import Hauptbahnhof

class TestSelection:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        Factory.bundle = Bundle(for:TestParsing.self)
        master = GameMaster()
    }
    
    func testSelectChangesState() {
        
    }
}
