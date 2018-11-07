import Foundation
import Editor

class Presenter {
    var updatedTitle:((String) -> Void)?
    var updated:(([String:Message]) -> Void)?
    var game = Game()
    
    func load() {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:"One", withExtension:"json")!)
        game = try! JSONDecoder().decode(Game.self, from:data)
        updatedTitle?(game.title)
        updated?(game.messages)
    }
}
