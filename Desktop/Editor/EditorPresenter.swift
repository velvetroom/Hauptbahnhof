import Cocoa
import Editor

class EditorPresenter {
    var selected = String()
    var viewModel = ViewModel()
    var observeTitle:((String) -> Void)?
    var observeStatus:((Status) -> Void)?
    var observeRenameStatus:((Status) -> Void)?
    var observeRenameSave:((Bool) -> Void)?
    var observeMessages:(([String:Message]) -> Void)?
    var shouldClearSelection:(() -> Void)?
    private let workshop = Workshop()
    
    func load() {
        updated(status:.loading())
        DispatchQueue.global(qos:.background).async {
            self.workshop.load(chapter:.One)
            self.updated(title:self.workshop.game.title)
            self.updatedMessages()
            self.validate()
        }
    }
    
    func validate() {
        updated(status:.loading())
        DispatchQueue.global(qos:.background).async {
            do {
                try self.workshop.validate()
                self.updated(status:.success())
            } catch let error {
                self.updated(status:.failed(error:error))
            }
        }
    }
    
    func validate(name:String) {
        updatedRename(saving:false)
        updatedRename(status:.loading())
        DispatchQueue.global(qos:.background).async {
            do {
                try self.workshop.validRename(self.selected, to:name)
                self.updatedRename(status:.success())
                self.updatedRename(saving:true)
            } catch let error {
                self.updatedRename(status:.failed(error:error))
                self.updatedRename(saving:false)
            }
        }
    }
    
    @objc func addMessage() {
        DispatchQueue.global(qos:.background).async {
            self.workshop.addMessage()
            self.updatedMessages()
            self.validate()
        }
    }
    
    @objc func rename() {
        let view = RenameView(presenter:self)
        Application.window.beginSheet(view) { response in
            if response == .continue {
                let id = view.text.string
                DispatchQueue.global(qos:.background).async {
                    self.workshop.rename(self.selected, to:id)
                    self.selected = id
                    self.updatedMessages()
                    self.validate()
                }
            }
        }
    }
    
    @objc func delete() {
        Application.window.beginSheet(DeleteView()) { response in
            if response == .continue {
                DispatchQueue.global(qos:.background).async {
                    self.workshop.deleteMessage(self.selected)
                    self.updatedMessages()
                    self.updatedClear()
                    self.validate()
                }
            }
        }
    }
    
    private func updatedMessages() { DispatchQueue.main.async { self.observeMessages?(self.workshop.game.messages) } }
    private func updated(title:String) { DispatchQueue.main.async { self.observeTitle?(title) } }
    private func updated(status:Status) { DispatchQueue.main.async { self.observeStatus?(status) } }
    private func updatedClear() { DispatchQueue.main.async { self.shouldClearSelection?() } }
    private func updatedRename(saving:Bool) { DispatchQueue.main.async { self.observeRenameSave?(saving) } }
    private func updatedRename(status:Status) { DispatchQueue.main.async { self.observeRenameStatus?(status) } }
}
