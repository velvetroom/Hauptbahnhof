import Foundation
import Hauptbahnhof

class Session:Storage {
    private let url = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).last!
    
    required init() { }
    func save(game:Game) { }
    
    func loadPlayer() throws -> Player {
        return try JSONDecoder().decode(Player.self, from:try Data(contentsOf:
            url.appendingPathComponent("Player.hauptbahnhof")))
    }
    
    func loadGame(chapter:Chapter) -> Game {
        return try! JSONDecoder().decode(Game.self, from:try Data(contentsOf:
            Bundle.main.url(forResource:chapter.rawValue, withExtension:".json")!))
    }
    
    func loadBoard() throws -> Board {
        return try JSONDecoder().decode(Board.self, from:try Data(contentsOf:
            url.appendingPathComponent("Board.hauptbahnhof")))
    }
    
    func save(player:Player) {
        DispatchQueue.global(qos:.background).async { [weak self] in
            guard let self = self else { return }
            try! (try! JSONEncoder().encode(player)).write(to:self.url.appendingPathComponent("Player.hauptbahnhof"))
        }
    }
    
    func save(board:Board) {
        DispatchQueue.global(qos:.background).async { [weak self] in
            guard let self = self else { return }
            try! (try! JSONEncoder().encode(board)).write(to:self.url.appendingPathComponent("Board.hauptbahnhof"))
        }
    }
}
