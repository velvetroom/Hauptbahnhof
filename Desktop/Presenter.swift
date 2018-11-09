import Cocoa
import Editor

class Presenter {
    var viewModelTitle:((String) -> Void)?
    var viewModelStatus:((Status) -> Void)?
    var viewModelMessages:(([String:Message]) -> Void)?
    var game = Game()
    
    func load() {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:"One", withExtension:"json")!)
        game = try! JSONDecoder().decode(Game.self, from:data)
        viewModelTitle?(game.title)
    }
    
    func validate() {
        DispatchQueue.global(qos:.background).async { [weak self] in
            
        }
    }
    
    private func updated(messages:[String:Message]) {
        DispatchQueue.main.async { [weak self] in self?.viewModelMessages?(messages) }
    }
    
    private func updated(title:String) {
        DispatchQueue.main.async { [weak self] in self?.viewModelTitle?(title) }
    }
    
    private func updated(status:Status) {
        DispatchQueue.main.async { [weak self] in self?.viewModelStatus?(status) }
    }
    
    private func statusLoading() -> Status {
        var status = Status()
        status.image = NSImage(named:"loading")!
        status.image.isTemplate = true
        return status
    }
    
    private func statusFailed(error:Error) -> Status {
        var status = Status()
        status.image = NSImage(named:"error")!
        status.image.isTemplate = true
        status.message = error.localizedDescription
        return status
    }
    
    private func statusSuccess() -> Status {
        var status = Status()
        status.image = NSImage(named:"valid")!
        status.image.isTemplate = true
        return status
    }
}
