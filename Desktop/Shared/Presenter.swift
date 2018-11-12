import Cocoa
import Editor

class Presenter {
    var viewModel = ViewModel()
    var messages:[String:Message] { return workshop.game.messages }
    private weak var timer:Timer?
    private let workshop = Workshop()
    
    func load() {
        status(.loading())
        DispatchQueue.global(qos:.background).async {
            self.workshop.load(chapter:.One)
            self.title()
            self.update()
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
    
    func update(text:String) {
        self.timer?.invalidate()
        let id = viewModel.selected!.id
        self.timer = Timer.scheduledTimer(withTimeInterval:3, repeats:false) {
            guard $0.isValid else { return }
            DispatchQueue.global(qos:.background).async {
                self.workshop.update(id, text:text)
            }
        }
    }
    
    func update(_ option:Option, next:String) {
        DispatchQueue.global(qos:.background).async {
            self.workshop.update(option, next:next)
        }
    }
    
    @objc func addMessage() {
        timer?.fire()
        viewModel.selected = nil
        workshop.addMessage()
        update()
        DispatchQueue.global(qos:.background).async {
            self.validate()
            DispatchQueue.main.async {
                self.viewModel.shouldSelect(String())
            }
        }
    }
    
    @objc func addOption() {
        timer?.fire()
        workshop.addOption(viewModel.selected!.id)
        viewModel.shouldSelect(viewModel.selected!.id)
        DispatchQueue.global(qos:.background).async {
            self.validate()
        }
    }
    
    @objc func rename() {
        timer?.fire()
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
        timer?.fire()
        Application.window.beginSheet(DeleteView()) { response in
            if response == .continue {
                let id = self.viewModel.selected!.id
                self.viewModel.selected = nil
                DispatchQueue.global(qos:.background).async {
                    self.workshop.deleteMessage(id)
                    self.update()
                    self.validate()
                }
            }
        }
    }
    
    @objc func edit(next:NSButton) {
        NSApp.runModal(for:NextView((next.superview as! OptionView), presenter:self))
    }
    
    @objc func show(next:NSButton) {
        viewModel.shouldSelect((next.superview as! OptionView).option.next)
    }
    
    private func update() { update { $0.messages(self.workshop.game.messages) } }
    private func title() { update { $0.title(self.workshop.game.title) } }
    private func status(_ status:Status) { update { $0.status(status) } }
    private func renaming(_ possible:Bool) { update { $0.renaming(possible) } }
    private func renameStatus(_ status:Status) { update { $0.renameStatus(status) } }
    private func update(_ async:@escaping(ViewModel) -> Void) { DispatchQueue.main.async{ async(self.viewModel) } }
}
