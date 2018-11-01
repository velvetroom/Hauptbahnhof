import CodableHero
import Hauptbahnhof

class Session:Storage {
    private let hero = Hero()
    required init() { }
    
    func load() throws -> Player {
        return try hero.load(path:"Player.hauptbahnhof")
    }
    
    func save(player:Player) {
        try! hero.save(model:player, path:"Player.hauptbahnhof")
    }
}
