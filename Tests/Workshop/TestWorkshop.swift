import XCTest
@testable import Hauptbahnhof

class TestWorkshop:XCTestCase {
    private var workshop:Workshop!

    override func setUp() {
        Factory.storage = MockStorage.self
        let data = try! Data(contentsOf:Bundle(for:TestParsing.self).url(forResource:"One", withExtension:"json")!)
        MockStorage.game = try! JSONDecoder().decode(Game.self, from:data)
        workshop = Workshop()
        workshop.load(chapter:.One)
    }
    
    override func tearDown() {
        MockStorage.game = Game()
    }
    
    func testLoadedChapter() {
        XCTAssertEqual("Chapter One", workshop.game.title)
    }
    
    func testAddMessage() {
        workshop.game.messages[""] = nil
        workshop.addMessage()
        XCTAssertNotNil(workshop.game.messages[""])
    }
    
    func testDoNotAddIfNewAlreadyExists() {
        let message = Message()
        message.text = "hello world"
        workshop.game.messages[""] = message
        workshop.addMessage()
        XCTAssertEqual("hello world", workshop.game.messages[""]!.text)
    }
    
    func testAddOption() {
        workshop.game.messages["a"] = Message()
        workshop.addOption("a")
        XCTAssertEqual(1, workshop.game.messages["a"]!.options.count)
    }
    
    func testAddEffect() {
        let option = Option()
        workshop.addEffect(option, effect:.increaseKnowledge)
        XCTAssertEqual(option.effects[0], .increaseKnowledge)
    }
    
    func testAddEffectNotRepeating() {
        let option = Option()
        option.effects = [.increaseScore10]
        workshop.addEffect(option, effect:.increaseScore10)
        XCTAssertEqual(1, option.effects.count)
    }
    
    func testRemoveEffect() {
        let option = Option()
        option.effects = [.increaseScore2]
        workshop.removeEffect(option, effect:.increaseScore2)
        XCTAssertTrue(option.effects.isEmpty)
    }
}
