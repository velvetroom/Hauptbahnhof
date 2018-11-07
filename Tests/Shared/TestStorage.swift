import XCTest
@testable import Editor

class TestStorage:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        Factory.bundle = Bundle(for:TestParsing.self)
        master = GameMaster()
    }
    
    override func tearDown() {
        MockStorage.onLoad = nil
        MockStorage.onSave = nil
    }
    
    func testMasterLoadsPlayer() {
        let expect = expectation(description:String())
        MockStorage.onLoad = { expect.fulfill() }
        let _ = GameMaster()
        waitForExpectations(timeout:1)
    }
}
