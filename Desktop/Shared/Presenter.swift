import Cocoa
import Editor

class Presenter {
    var viewModel = ViewModel()
    var messages:[String:Message] { return workshop.game.messages }
    var effects:[Effect] { return Effect.allCases }
    private weak var timer:Timer?
    private let workshop = Workshop()
    
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
        let id = viewModel.selected!.id
        schedule { self.workshop.update(id, text:text) }
    }
    
    func update(_ option:Option, text:String) {
        schedule { self.workshop.update(option, text:text) }
    }
    
    func update(_ option:Option, next:String) {
        DispatchQueue.global(qos:.background).async {
            self.workshop.update(option, next:next)
            self.validate()
        }
    }
    
    func addEffect(_ option:Option, id:String) {
        workshop.addEffect(option, effect:Effect(rawValue:id)!)
        viewModel.shouldSelect(viewModel.selected!.id)
    }
    
    @objc func load(_ chapter:NSPopUpButton) {
        viewModel.selected = nil
        status(.loading())
        let chapter = Chapter(rawValue:chapter.titleOfSelectedItem!)!
        DispatchQueue.global(qos:.background).async {
            self.workshop.load(chapter:chapter)
            self.update()
            self.validate()
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
    
    @objc func addEffect(add:NSButton) {
        timer?.fire()
        NSApp.runModal(for:EffectView((add.superview as! OptionView), presenter:self))
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
    
    @objc func deleteMessage() {
        timer?.fire()
        Application.window.beginSheet(DeleteView(.local("Presenter.deleteMessage"))) { response in
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
    
    @objc func delete(option:NSButton) {
        timer?.fire()
        Application.window.beginSheet(DeleteView(.local("Presenter.deleteOption"))) { response in
            if response == .continue {
                let option = (option.superview as! OptionView).option!
                DispatchQueue.global(qos:.background).async {
                    self.workshop.deleteOption(option)
                    self.validate()
                    DispatchQueue.main.async {
                        self.viewModel.shouldSelect(self.viewModel.selected!.id)
                    }
                }
            }
        }
    }
    
    @objc func removeEffect(remove:NSButton) {
        timer?.fire()
        let option = remove.superview as! OptionView
        workshop.removeEffect(option.option, effect:Effect(rawValue:option.item!.id)!)
        viewModel.shouldSelect(viewModel.selected!.id)
    }
    
    @objc func edit(next:NSButton) {
        NSApp.runModal(for:NextView((next.superview as! OptionView), presenter:self))
    }
    
    @objc func show(next:NSButton) {
        viewModel.shouldSelect((next.superview as! OptionView).option.next)
    }
    
    @objc func history(button:NSButton) {
        viewModel.shouldSelect(button.title)
    }
    
    private func schedule(timeout:@escaping(() -> Void)) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval:0.8, repeats:false) {
            guard $0.isValid else { return }
            DispatchQueue.global(qos:.background).async {
                timeout()
                self.validate()
            }
        }
    }
    
    private func update() { update { $0.messages(self.messages) } }
    private func status(_ status:Status) { update { $0.status(status) } }
    private func renaming(_ possible:Bool) { update { $0.renaming(possible) } }
    private func renameStatus(_ status:Status) { update { $0.renameStatus(status) } }
    private func update(_ async:@escaping(ViewModel) -> Void) { DispatchQueue.main.async{ async(self.viewModel) } }
}
