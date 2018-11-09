import CodableHero
import Hauptbahnhof

class Session:Storage {
    private let hero = Hero()
    required init() { }
    
    func loadPlayer() throws -> Player {
        return try hero.load(path:"Player.hauptbahnhof")
    }
    
    func loadGame(chapter:String) -> Game {
        return try! hero.load(bundle:Factory.bundle, path:chapter + ".json")
    }
    
    func save(player:Player) {
        try! hero.save(model:player, path:"Player.hauptbahnhof")
    }
}
