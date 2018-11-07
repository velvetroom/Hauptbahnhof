import Foundation
@testable import Editor

class MockStorage:Storage {
    static var profile = Player()
    static var onSave:(() -> Void)?
    static var onLoad:(() -> Void)?
    
    required init() { }
    
    func load() throws -> Player {
        MockStorage.onLoad?()
        return MockStorage.profile
    }
    
    func save(player:Player) {
        MockStorage.onSave?()
    }
}
