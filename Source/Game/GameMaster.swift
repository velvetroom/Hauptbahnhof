import Foundation

public class GameMaster {
    public private(set) var game = Game()
    public private(set) var player = Player()
    private let storage = Factory.makeStorage()
    
    public init() {
        if let player = try? storage.loadPlayer() {
            self.player = player
        }
        game = storage.loadGame(chapter:player.chapter)
    }
    
    public var message:Message { return game.messages[player.state]! }
}
