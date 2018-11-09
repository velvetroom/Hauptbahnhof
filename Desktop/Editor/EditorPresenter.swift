import Cocoa
import Editor

class EditorPresenter {
    var selected = String()
    var viewModelTitle:((String) -> Void)?
    var viewModelStatus:((EditorStatus) -> Void)?
    var viewModelMessages:(([String:Message]) -> Void)?
    var viewModelSelected:((String) -> Void)?
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
            self?.validate()
            self?.updated(selected:String())
        }
    }
    
    @objc func rename() {
        let window = NSWindow(contentRect:NSRect(x:0, y:0, width:260, height:200), styleMask:.titled,
                              backing:.buffered, defer:false)
        let view = RenameView()
        view.presenter.id = selected
        window.contentView = view
        Application.window.beginSheet(window)
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
    
    private func updated(status:EditorStatus) {
        DispatchQueue.main.async { [weak self] in self?.viewModelStatus?(status) }
    }
    
    private func updated(selected:String) {
        DispatchQueue.main.async { [weak self] in self?.viewModelSelected?(selected) }
    }
    
    private func statusLoading() -> EditorStatus {
        var status = EditorStatus()
        status.image = NSImage(named:"loading")!
        status.image.isTemplate = true
        return status
    }
    
    private func statusFailed(error:Error) -> EditorStatus {
        var status = EditorStatus()
        status.image = NSImage(named:"error")!
        status.image.isTemplate = true
        status.message = error.localizedDescription
        return status
    }
    
    private func statusSuccess() -> EditorStatus {
        var status = EditorStatus()
        status.image = NSImage(named:"valid")!
        status.image.isTemplate = true
        return status
    }
}
