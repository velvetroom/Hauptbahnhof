import Cocoa
import Editor

class Session:Storage {
    private var bookmarks = [String:Data]()
    
    required init() {
        loadBookmarks()
        missingBookmarks()
    }
    
    func loadPlayer() throws -> Player { throw Exception.unknown }
    func save(player:Player) { }
    
    func loadGame(chapter:Chapter) -> Game {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:chapter.rawValue, withExtension:"json")!)
        return try! JSONDecoder().decode(Game.self, from:data)
    }
    
    func save(game:Game) {
        let chapter = game.chapter
        let data = try! JSONEncoder().encode(game)
        try! save(chapter:chapter, data:data)
    }
    
    private func loadBookmarks() {
        if let bookmarks = UserDefaults.standard.value(forKey:"bookmarks") as? [String:Data] {
            self.bookmarks = bookmarks
        }
        bookmarks.forEach { chapter, data in
            var stale = false
            let url = try! URL(resolvingBookmarkData:data, options:.withSecurityScope, bookmarkDataIsStale:&stale)
            let _ = url.startAccessingSecurityScopedResource()
        }
    }
    
    private func missingBookmarks() {
        Chapter.allCases.forEach { chapter in
            if chapter != .Unknown && bookmarks[chapter.rawValue] == nil {
                showPanel(chapter:chapter)
            }
        }
    }
    
    private func save(chapter:Chapter, data:Data) throws {
        let url = URL(fileURLWithPath:"/devel/iturbide/Hauptbahnhof/Resources/\(chapter.rawValue).json")
        try data.write(to:url)
    }
    
    private func showPanel(chapter:Chapter) {
        DispatchQueue.main.async {
            let panel = NSOpenPanel()
            panel.message = .local("Session.openPanel") + chapter.rawValue
            panel.allowedFileTypes = ["json"]
            panel.nameFieldStringValue = chapter.rawValue
            panel.begin { [weak self] response in
                if response == .OK {
                    let data = try! panel.url!.bookmarkData(options:.withSecurityScope)
                    self?.addBookmark(chapter:chapter, data:data)
                }
            }
        }
    }
    
    private func addBookmark(chapter:Chapter, data:Data) {
        bookmarks[chapter.rawValue] = data
        UserDefaults.standard.set(bookmarks, forKey:"bookmarks")
    }
}
