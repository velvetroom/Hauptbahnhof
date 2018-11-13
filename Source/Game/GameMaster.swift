import Foundation

public class GameMaster {
    public internal(set) var game = Game()
    public internal(set) var player = Player()
    public var message:Message { return game.messages[player.state]! }
    private let storage = Factory.makeStorage()
    
    public init() {
        if let player = try? storage.loadPlayer() {
            self.player = player
        }
        game = storage.loadGame(chapter:player.chapter)
    }
    
    public func select(_ option:Option) {
        player.state = option.next
        storage.save(player:player)
    }
}
