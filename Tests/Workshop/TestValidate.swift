import XCTest
@testable import Hauptbahnhof

class TestValidate:XCTestCase {
    private var validator:Validator!
    private var game:Game!
    
    override func setUp() {
        validator = Validator()
        game = Game()
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
        messageB.text = "lorem ipsum"
        game.messages["initial"] = messageA
        game.messages["final"] = messageB
    }
    
    func testSuccess() {
        XCTAssertNoThrow(try validator.validate(game))
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
    
    func testMessageIsOnMainLine() {
        let messageA = Message()
        messageA.text = "hello world"
        let optionA = Option()
        optionA.text = "hello"
        optionA.next = "loopB"
        let optionB = Option()
        optionB.text = "world"
        optionB.next = "loopB"
        messageA.options = [optionA, optionB]
        let messageB = Message()
        messageB.text = "hello world"
        let optionC = Option()
        optionC.text = "hello"
        optionC.next = "loopA"
        let optionD = Option()
        optionD.text = "world"
        optionD.next = "loopA"
        messageB.options = [optionC, optionD]
        game.messages["loopA"] = messageA
        game.messages["loopB"] = messageB
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
    
    func testNextInitial() {
        let messageA = Message()
        messageA.text = "hello world"
        let optionA = Option()
        optionA.text = "hello"
        optionA.next = "initial"
        let optionB = Option()
        optionB.text = "world"
        optionB.next = "final"
        messageA.options = [optionA, optionB]
        let optionE = Option()
        optionE.text = "loop"
        optionE.next = "messageA"
        game.messages["messageA"] = messageA
        game.messages["initial"]!.options.append(optionE)
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testFinalWithOptions() {
        let messageA = Message()
        messageA.text = "hello world"
        let optionA = Option()
        optionA.text = "hello"
        optionA.next = "final"
        let optionB = Option()
        optionB.text = "world"
        optionB.next = "final"
        messageA.options = [optionA, optionB]
        let option = Option()
        option.text = "hello"
        option.next = "messageA"
        game.messages["messageA"] = messageA
        game.messages["final"]!.options = [option]
        XCTAssertThrowsError(try validator.validate(game))
    }
    
    func testGraphToFinal() {
        let messageA = Message()
        messageA.text = "hello world"
        let optionA = Option()
        optionA.text = "hello"
        optionA.next = "loopB"
        let optionB = Option()
        optionB.text = "world"
        optionB.next = "loopB"
        messageA.options = [optionA, optionB]
        let messageB = Message()
        messageB.text = "hello world"
        let optionC = Option()
        optionC.text = "hello"
        optionC.next = "loopA"
        let optionD = Option()
        optionD.text = "world"
        optionD.next = "loopA"
        messageB.options = [optionC, optionD]
        let optionE = Option()
        optionE.text = "loop"
        optionE.next = "loopA"
        game.messages["loopA"] = messageA
        game.messages["loopB"] = messageB
        game.messages["initial"]!.options.append(optionE)
        XCTAssertThrowsError(try validator.validate(game))
    }
}
