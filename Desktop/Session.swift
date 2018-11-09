import Cocoa
import Editor

class Session:Storage {
    required init() { }
    func loadPlayer() throws -> Player { throw Exception.unknown }
    func save(player:Player) { }
    
    func loadGame(chapter:Chapter) -> Game {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:chapter.rawValue, withExtension:"json")!)
        return try! JSONDecoder().decode(Game.self, from:data)
    }
    
    func save(game:Game) {
        let chapter = game.chapter
        let data = try! JSONEncoder().encode(game)
        do {
            try save(chapter:chapter, data:data)
        } catch {
            showPanel(chapter:chapter) { [weak self] in
                try? self?.save(chapter:chapter, data:data)
            }
        }
    }
    
    private func save(chapter:Chapter, data:Data) throws {
        let url = URL(fileURLWithPath:"/devel/iturbide/Hauptbahnhof/Resources/\(chapter.rawValue).json")
        try data.write(to:url)
    }
    
    private func showPanel(chapter:Chapter, completion:@escaping(() -> Void)) {
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.allowedFileTypes = ["json"]
            panel.nameFieldStringValue = chapter.rawValue
            panel.begin { response in
                if response == .OK {
                    completion()
                }
            }
        }
    }
}
