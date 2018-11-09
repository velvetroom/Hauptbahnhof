import Foundation

public class Workshop {
    public var game = Game()
    private let storage = Factory.makeStorage()
    private let validator = Validator()
    
    public init() { }
    
    public func load(chapter:Chapter) {
        game = storage.loadGame(chapter:chapter)
    }
    
    public func validate() throws {
        try validator.validate(game)
    }
    
    public func addMessage() {
        if game.messages[String()] == nil {
            game.messages[String()] = Message()
            storage.save(game:game)
        }
    }
}
