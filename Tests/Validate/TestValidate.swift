import XCTest
@testable import Hauptbahnhof

class TestValidate:XCTestCase {
    private var validator:Validator!
    
    override func setUp() {
        validator = Validator()
    }
    
    func testSuccess() {
        XCTAssertNoThrow(try? validator.validate(Game()))
    }
}
