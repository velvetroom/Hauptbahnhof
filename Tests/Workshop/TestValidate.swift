import XCTest
@testable import Hauptbahnhof

class TestValidate:XCTestCase {
    private var validator:Validator!
    private var game:Game!
    
    override func setUp() {
        validator = Validator()
        game = Game()
        game.title = "Lorem ipsum"
        let messageA = Message()
        messageA.text = "hello world"
        let optionA = Option()
        optionA.text = "hello"
        optionA.next = "final"
        let optionB = Option()
        optionB.text = "world"
        optionB.next = "final"
        messageA.options = [optionA, optionB]
        let messageB = Message()
        messageB.text = "hello world"
        let optionC = Option()
        optionC.text = "hello"
        optionC.next = "initial"
        let optionD = Option()
        optionD.text = "world"
        optionD.next = "initial"
        messageB.options = [optionC, optionD]
        game.messages["initial"] = messageA
        game.messages["final"] = messageB
    }
    
    func testSuccess() {
        XCTAssertNoThrow(try validator.validate(game))
    }
    
    func testTitleEmpty() {
        game.title = ""
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testMessagesEmpty() {
        game.messages = [:]
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testIdEmpty() {
        game.messages[""] = game.messages["initial"]
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testNoInitial() {
        game.messages["another"] = game.messages["initial"]
        game.messages["another"]!.options[0].next = "another"
        game.messages["another"]!.options[1].next = "another"
        game.messages["initial"] = nil
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testOrphanMessage() {
        game.messages["orphan"] = game.messages["initial"]
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testTextEmpty() {
        game.messages["initial"]!.text = ""
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testTextEndsNewLine() {
        game.messages["initial"]!.text = "hello world\n"
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testOptionsEmpty() {
        game.messages["initial"]!.options = []
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testOptionsLessThanTwo() {
        game.messages["initial"]!.options = [game.messages["initial"]!.options.first!]
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testOptionEndsNewLine() {
        game.messages["initial"]!.options.first!.text = "lorem ipsum\n"
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testNextInvalid() {
        game.messages["initial"]!.options.first!.next = "some weirdness"
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testNextEmpty() {
        game.messages[""] = Message()
        game.messages["initial"]!.options.first!.next = ""
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testNextRecursive() {
        game.messages["initial"]!.options.first!.next = "initial"
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testOptionTextEmpty() {
        game.messages["initial"]!.options.first!.text = ""
        XCTAssertThrowsError(try validator.validate(game))
    }
}
