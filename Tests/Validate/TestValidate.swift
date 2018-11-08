import XCTest
@testable import Hauptbahnhof

class TestValidate:XCTestCase {
    private var validator:Validator!
    private var game:Game!
    
    override func setUp() {
        validator = Validator()
        game = Game()
        game.title = "Lorem ipsum"
        let message = Message()
        message.text = "hello world"
        let optionA = Option()
        optionA.next = "initial"
        let optionB = Option()
        optionB.next = "initial"
        message.options = [optionA, optionB]
        game.messages["initial"] = message
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
    
    func testTextEmpty() {
        game.messages["initial"]!.text = ""
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
    
    func testNextInvalid() {
        game.messages["initial"]!.options.first!.next = "some weirdness"
        XCTAssertThrowsError(try validator.validate(game))
    }
}
