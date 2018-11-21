import XCTest
@testable import Hauptbahnhof

class TestRate:XCTestCase {
    private var master:GameMaster!
    
    override func setUp() {
        Factory.storage = MockStorage.self
        master = GameMaster()
    }
    
    func testNoRateAtFirst() {
        XCTAssertFalse(master.rate())
    }
    
    func testRateIfMoreContinuesModulesFive() {
        master.board.continues = 4
        XCTAssertTrue(master.rate())
        XCTAssertFalse(master.board.rates.isEmpty)
    }
    
    func testNoRateIfRatedRecently() {
        master.board.continues = 4
        master.board.rates = [Date()]
        XCTAssertFalse(master.rate())
    }
    
    func testRateIfRatedMoreThan2MonthsAgo() {
        var components = DateComponents()
        components.month = 3
        let date = Calendar.current.date(byAdding:components, to:Date())!
        master.board.continues = 4
        master.board.rates = [date]
        XCTAssertEqual(date, master.board.rates.last!)
        XCTAssertTrue(master.rate())
        XCTAssertNotEqual(date, master.board.rates.last!)
    }
}
