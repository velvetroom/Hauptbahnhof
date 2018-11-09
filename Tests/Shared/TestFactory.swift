import XCTest
@testable import Hauptbahnhof

class TestFactory:XCTestCase {
    override func setUp() {
        Factory.storage = MockStorage.self
    }
    
    func testGameMasterMonostate() {
        XCTAssertTrue(Factory.makeMaster() === Factory.makeMaster())
    }
}
