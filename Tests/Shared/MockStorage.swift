import Foundation
@testable import Hauptbahnhof

class MockStorage:Storage {
    static var onSavePlayer:(() -> Void)?
    static var onSaveGame:(() -> Void)?
    static var onLoadPlayer:(() -> Void)?
    static var onLoadGame:(() -> Void)?
    static var onLoadBoard:(() -> Void)?
    
    required init() { }
    
    func loadPlayer() throws -> Player {
        MockStorage.onLoadPlayer?()
        return Player()
    }
    
    func loadGame(chapter:Chapter) -> Game {
        MockStorage.onLoadGame?()
        var game = Game()
        game.chapter = .Prologue
        game.messages["initial"] = Message()
        return game
    }
    
    func loadBoard() throws -> Board {
        MockStorage.onLoadBoard?()
        return Board()
    }
    
    func save(player:Player) {
        MockStorage.onSavePlayer?()
    }
    
    func save(game:Game) {
        MockStorage.onSaveGame?()
    }
}
