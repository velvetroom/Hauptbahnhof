import Foundation
import Editor

class Presenter {
    var updatedTitle:((String) -> Void)?
    var updatedMessages:(([(String, Int)]) -> Void)?
    var game = Game()
    
    func load() {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:"One", withExtension:"json")!)
        game = try! JSONDecoder().decode(Game.self, from:data)
        updatedTitle?(game.title)
        updateMessages()
    }
    
    private func updateMessages() {
        updatedMessages?(game.messages.map { id, message in
            return (id, message.options.count)
        })
    }
}
