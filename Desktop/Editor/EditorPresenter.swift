import Cocoa
import Editor

class EditorPresenter {
    var selected = String()
    var viewModelTitle:((String) -> Void)?
    var viewModelStatus:((Status) -> Void)?
    var viewModelMessages:(([String:Message]) -> Void)?
    var viewModelSelected:((String) -> Void)?
    var viewModelClearSelection:(() -> Void)?
    private let workshop = Workshop()
    
    func load() {
        updated(status:.loading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundLoad() }
    }
    
    func validate() {
        updated(status:.loading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundValidate() }
    }
    
    @objc func addMessage() {
        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.workshop.addMessage()
            self?.updatedMessages()
            self?.validate()
            self?.updated(selected:String())
        }
    }
    
    @objc func rename() {
        let window = NSWindow(contentRect:NSRect(x:0, y:0, width:260, height:200), styleMask:.titled,
                              backing:.buffered, defer:false)
        let view = RenameView()
        view.presenter.workshop = workshop
        view.presenter.id = selected
        window.contentView = view
        Application.window.beginSheet(window) { [weak self] _ in
            self?.updatedMessages()
            self?.validate()
            self?.updatedClear()
        }
    }
    
    @objc func delete() {
        let window = NSWindow(contentRect:NSRect(x:0, y:0, width:200, height:100), styleMask:.titled,
                              backing:.buffered, defer:false)
        let view = DeleteView()
        window.contentView = view
        Application.window.beginSheet(window) { response in
            if response == .continue {
                DispatchQueue.global(qos:.background).async { [weak self] in
                    self?.confirmDelete()
                }
            }
        }
    }
    
    private func backgroundLoad() {
        workshop.load(chapter:.One)
        updated(title:workshop.game.title)
        updatedMessages()
        validate()
    }
    
    private func backgroundValidate() {
        do {
            try workshop.validate()
            updated(status:.success())
        } catch let error {
            updated(status:.failed(error:error))
        }
    }
    
    private func confirmDelete() {
        workshop.deleteMessage(selected)
        updatedMessages()
        updatedClear()
        validate()
    }
    
    private func updatedMessages() {
        let messages = workshop.game.messages
        DispatchQueue.main.async { [weak self] in self?.viewModelMessages?(messages) }
    }
    
    private func updated(title:String) {
        DispatchQueue.main.async { [weak self] in self?.viewModelTitle?(title) }
    }
    
    private func updated(status:Status) {
        DispatchQueue.main.async { [weak self] in self?.viewModelStatus?(status) }
    }
    
    private func updated(selected:String) {
        DispatchQueue.main.async { [weak self] in self?.viewModelSelected?(selected) }
    }
    
    private func updatedClear() {
        DispatchQueue.main.async { [weak self] in self?.viewModelClearSelection?() }
    }
}
