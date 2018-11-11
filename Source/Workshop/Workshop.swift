import Foundation

public class Workshop {
    public var game = Game()
    private let storage = Factory.makeStorage()
    private let validator = Validator()
    
    public init() { }
    
    public func load(chapter:Chapter) {
        game = storage.loadGame(chapter:chapter)
    }
    
    public func validate() throws {
        try validator.validate(game)
    }
    
    public func addMessage() {
        if game.messages[String()] == nil {
            game.messages[String()] = Message()
            save()
        }
    }
    
    public func validRename(_ id:String, to:String) throws {
        if to.isEmpty { throw Exception.emptyName }
        let to = to.lowercased()
        try game.messages.keys.forEach { item in
            if item.lowercased() == to && item != id {
                throw Exception.nameExists
            }
        }
    }
    
    public func rename(_ id:String, to:String) {
        game.messages[to] = game.messages[id]
        game.messages.removeValue(forKey:id)
        if !id.isEmpty {
            game.messages.values.forEach { $0.options.forEach { if $0.next == id { $0.next = to } } }
        }
        save()
    }
    
    public func deleteMessage(_ id:String) {
        game.messages.values.forEach { $0.options.forEach { if $0.next == id { $0.next = String() } } }
        game.messages.removeValue(forKey:id)
        save()
    }
    
    public func update(_ id:String, text:String) {
        game.messages[id]!.text = text
        save()
    }
    
    public func update(_ option:Option, next:String) {
        option.next = next
        save()
    }
    
    private func save() {
        storage.save(game:game)
    }
}
