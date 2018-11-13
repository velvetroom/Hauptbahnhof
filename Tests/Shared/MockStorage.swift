import Foundation
@testable import Hauptbahnhof

class MockStorage:Storage {
    static var onSavePlayer:(() -> Void)?
    static var onSaveGame:(() -> Void)?
    static var onLoadPlayer:(() -> Void)?
    static var onLoadGame:(() -> Void)?
    
    required init() { }
    
    func loadPlayer() throws -> Player {
        MockStorage.onLoadPlayer?()
        return Player()
    }
    
    func loadGame(chapter:Chapter) -> Game {
        MockStorage.onLoadGame?()
        return Game()
    }
    
    func save(player:Player) {
        MockStorage.onSavePlayer?()
    }
    
    func save(game:Game) {
        MockStorage.onSaveGame?()
    }
}
