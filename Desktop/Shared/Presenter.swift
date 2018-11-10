import Cocoa
import Editor

class Presenter {
    var viewModel = ViewModel()
    private let workshop = Workshop()
    
    func load() {
        status(.loading())
        DispatchQueue.global(qos:.background).async {
            self.workshop.load(chapter:.One)
            self.title()
            self.messages()
            self.validate()
        }
    }
    
    func validate() {
        status(.loading())
        DispatchQueue.global(qos:.background).async {
            do {
                try self.workshop.validate()
                self.status(.success())
            } catch let error {
                self.status(.failed(error))
            }
        }
    }
    
    func validate(name:String) {
        renaming(false)
        renameStatus(.loading())
        DispatchQueue.global(qos:.background).async {
            do {
                try self.workshop.validRename(self.viewModel.selected!.id, to:name)
                self.renameStatus(.success())
                self.renaming(true)
            } catch let error {
                self.renameStatus(.failed(error))
                self.renaming(false)
            }
        }
    }
    
    @objc func addMessage() {
        viewModel.selected = nil
        workshop.addMessage()
        messages()
        DispatchQueue.global(qos:.background).async {
            self.validate()
        }
    }
    
    @objc func rename() {
        let view = RenameView(presenter:self)
        Application.window.beginSheet(view) { response in
            if response == .continue {
                let new = view.text.string
                let old = self.viewModel.selected!.id
                self.viewModel.selected!.id = new
                DispatchQueue.global(qos:.background).async {
                    self.workshop.rename(old, to:new)
                    self.validate()
                }
            }
        }
    }
    
    @objc func delete() {
        Application.window.beginSheet(DeleteView()) { response in
            if response == .continue {
                let id = self.viewModel.selected!.id
                self.viewModel.selected = nil
                DispatchQueue.global(qos:.background).async {
                    self.workshop.deleteMessage(id)
                    self.messages()
                    self.validate()
                }
            }
        }
    }
    
    private func messages() { update { $0.messages(self.workshop.game.messages) } }
    private func title() { update { $0.title(self.workshop.game.title) } }
    private func status(_ status:Status) { update { $0.status(status) } }
    private func renaming(_ possible:Bool) { update { $0.renaming(possible) } }
    private func renameStatus(_ status:Status) { update { $0.renameStatus(status) } }
    private func update(_ async:@escaping(ViewModel) -> Void) { DispatchQueue.main.async{ async(self.viewModel) } }
}
