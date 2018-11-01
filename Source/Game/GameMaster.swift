import Foundation

public class GameMaster {
    public private(set) var game = Game()
    public private(set) var player = Player()
    private let storage = Factory.makeStorage()
    
    public init() {
        if let player = try? storage.load() {
            self.player = player
        }
    }
    
    public func load(_ data:Data) {
        game = try! JSONDecoder().decode(Game.self, from:data)
    }
    
    public var message:Message { return game.messages[game.state]! }
}
