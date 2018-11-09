import Foundation
import Editor

class Session:Storage {
    required init() { }
    func loadPlayer() throws -> Player { throw Exception.unknown }
    func save(player:Player) { }
    
    func loadGame(chapter:String) -> Game {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:chapter, withExtension:"json")!)
        return try! JSONDecoder().decode(Game.self, from:data)
    }
}
