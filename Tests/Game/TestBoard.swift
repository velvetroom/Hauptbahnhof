import XCTest
@testable import Hauptbahnhof

class TestBoard:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
}
