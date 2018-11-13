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
        option.effects.forEach { apply($0) }
        storage.save(player:player)
    }
    
    private func apply(_ effect:Effect) {
        switch effect {
        case .increaseScore2: player.score += 2
        case .increaseScore10: player.score += 10
        case .increaseCourage: player.courage = min(100, player.courage + 1)
        case .increaseEmpathy: player.empathty = min(100, player.empathty + 1)
        case .increaseDiligence: player.diligence = min(100, player.diligence + 1)
        case .increaseKnowledge: player.knowledge = min(100, player.knowledge + 1)
        }
    }
}
