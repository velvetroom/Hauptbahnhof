import XCTest
@testable import Hauptbahnhof

class TestWorkshop:XCTestCase {
    private var workshop:Workshop!

    override func setUp() {
        Factory.storage = MockStorage.self
        workshop = Workshop()
        workshop.load(chapter:.One)
    }
    
    func testLoadedChapter() {
        XCTAssertEqual("Chapter One", workshop.game.title)
    }
    
    func testAddMessage() {
        XCTAssertNil(workshop.game.messages[""])
        workshop.addMessage()
        XCTAssertNotNil(workshop.game.messages[""])
    }
}
