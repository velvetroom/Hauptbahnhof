import XCTest
@testable import Hauptbahnhof

class TestFactory:XCTestCase {
    override func setUp() {
        Factory.storage = MockStorage.self
        Factory.bundle = Bundle(for:TestParsing.self)
    }
    
    func testGameMasterMonostate() {
        XCTAssertTrue(Factory.makeMaster() === Factory.makeMaster())
    }
}
