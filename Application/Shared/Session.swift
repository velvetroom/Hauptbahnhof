import CodableHero
import Hauptbahnhof

class Session:Storage {
    private let hero = Hero()
    required init() { }
    func save(game:Game) { }
    
    func loadPlayer() throws -> Player {
        return try hero.load(path:"Player.hauptbahnhof")
    }
    
    func loadGame(chapter:Chapter) -> Game {
        return try! hero.load(bundle:.main, path:chapter.rawValue + ".json")
    }
    
    func save(player:Player) {
        try! hero.save(model:player, path:"Player.hauptbahnhof")
    }
}
