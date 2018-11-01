import Foundation

public class GameMaster {
    public private(set) var game = Game()
    
    public init() { }
    
    public func load(_ data:Data) {
        game = try! JSONDecoder().decode(Game.self, from:data)
    }
    
    public var message:Message { return game.messages[game.state]! }
}
