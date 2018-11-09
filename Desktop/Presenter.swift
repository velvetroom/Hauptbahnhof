import Cocoa
import Editor

class Presenter {
    var viewModelTitle:((String) -> Void)?
    var viewModelStatus:((Status) -> Void)?
    var viewModelMessages:(([String:Message]) -> Void)?
    private var validator = Validator()
    private let workshop = Workshop()
    
    func load() {
        updated(status:statusLoading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundLoad() }
    }
    
    func validate() {
        updated(status:statusLoading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundValidate() }
    }
    
    @objc func addMessage() {
        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.workshop.addMessage()
            guard let messages = self?.workshop.game.messages else { return }
            self?.updated(messages:messages)
        }
    }
    
    private func backgroundLoad() {
        workshop.load(chapter:.One)
        updated(title:workshop.game.title)
        updated(messages:workshop.game.messages)
        validate()
    }
    
    private func backgroundValidate() {
        do {
            try validator.validate(workshop.game)
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
