import Cocoa
import Editor

class Presenter {
    var viewModelTitle:((String) -> Void)?
    var viewModelStatus:((Status) -> Void)?
    var viewModelMessages:(([String:Message]) -> Void)?
    private var master:GameMaster!
    private var validator = Validator()
    
    func load() {
        updated(status:statusLoading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundLoad() }
    }
    
    func validate() {
        updated(status:statusLoading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundValidate() }
    }
    
    private func backgroundLoad() {
        master = GameMaster()
        updated(title:master.game.title)
        updated(messages:master.game.messages)
        validate()
    }
    
    private func backgroundValidate() {
        do {
            try validator.validate(master.game)
        } catch let error {
            updated(status:statusFailed(error:error))
            return
        }
        updated(status:statusSuccess())
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
        status.message = String(describing:error)
        return status
    }
    
    private func statusSuccess() -> Status {
        var status = Status()
        status.image = NSImage(named:"valid")!
        status.image.isTemplate = true
        return status
    }
}
