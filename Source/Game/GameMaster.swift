import Foundation

public class GameMaster {
    public private(set) var game = Game()
    public private(set) var player = Player()
    private let storage = Factory.makeStorage()
    
    public init() {
        if let player = try? storage.load() {
            self.player = player
        }
        loadGame()
    }
    
    public var message:Message { return game.messages[player.state]! }
    
    private func loadGame() {
        let data = try! Data(contentsOf:Factory.bundle.url(forResource:player.chapter, withExtension:"json")!)
        game = try! JSONDecoder().decode(Game.self, from:data)
    }
}
