import Foundation

public class GameMaster {
    public var message:Message { return game.messages[player.state]! }
    public internal(set) var game = Game()
    public internal(set) var player = Player()
    public internal(set) var board = Board()
    private let storage = Factory.makeStorage()
    
    public init() {
        if let board = try? storage.loadBoard() {
            self.board = board
        }
        if let player = try? storage.loadPlayer() {
            self.player = player
        }
        game = storage.loadGame(chapter:player.chapter)
    }
    
    public func select(_ option:Option) {
        player.state = option.next
        option.effects.forEach { apply($0) }
        player.syncstamp = Date().timeIntervalSince1970
        storage.save(player:player)
    }
    
    public func restart() {
        player = Player()
        storage.save(player:player)
    }
    
    public func rate() -> Bool {
        var rating = false
        board.continues += 1
        if (board.continues % 5) == 0 {
            if let last = board.rates.last,
                let months = Calendar.current.dateComponents([.month], from:last, to:Date()).month {
                rating = months < -1
            } else {
                rating = true
            }
        }
        if rating {
            board.rates.append(Date())
        }
        storage.save(board:board)
        return rating
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
