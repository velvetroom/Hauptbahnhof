import Cocoa

class RenameView:NSWindow, NSTextViewDelegate {
    private(set) weak var text:NSTextView!
    private weak var presenter:Presenter!
    private weak var status:NSImageView!
    private weak var statusText:NSTextField!
    private weak var save:NSButton!
    
    override func cancelOperation(_:Any?) { stopEditing() }
    
    init(presenter:Presenter) {
        self.presenter = presenter
        super.init(contentRect:NSRect(x:0, y:0, width:260, height:200), styleMask:.titled, backing:.buffered,
                   defer:false)
        makeOutlets()
        presenter.viewModel.renaming = { self.save.isEnabled = $0 }
        presenter.viewModel.renameStatus = {
            self.status.image = $0.image
            self.statusText.stringValue = $0.message
        }
    }
    
    func textDidChange(_:Notification) {
        presenter.validate(name:text.string)
    }
    
    func textView(_:NSTextView, doCommandBy selector:Selector) -> Bool {
        if (selector == #selector(NSResponder.insertNewline(_:))) {
            stopEditing()
            return true
        }
        return false
    }
    
    private func makeOutlets() {
        let title = NSTextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize:14, weight:.bold)
        title.backgroundColor = .clear
        title.isBezeled = false
        title.isEditable = false
        title.stringValue = .local("RenameView.title")
        contentView!.addSubview(title)
        
        let text = NSTextView(frame:.zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.wantsLayer = true
        text.layer!.cornerRadius = 12
        text.textContainerInset = NSSize(width:10, height:7)
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.size = NSSize(width:240, height:33)
        text.textContainer!.lineBreakMode = .byTruncatingHead
        text.font = .systemFont(ofSize:16, weight:.light)
        text.delegate = self
        text.string = presenter.viewModel.selected!.id
        contentView!.addSubview(text)
        self.text = text
        
        let status = NSImageView(frame:.zero)
        status.isEnabled = false
        status.imageScaling = .scaleNone
        status.contentTintColor = .selectedMenuItemColor
        status.translatesAutoresizingMaskIntoConstraints = false
        contentView!.addSubview(status)
        self.status = status
        
        let statusText = NSTextField()
        statusText.translatesAutoresizingMaskIntoConstraints = false
        statusText.font = .systemFont(ofSize:12, weight:.light)
        statusText.backgroundColor = .clear
        statusText.alignment = .center
        statusText.isBezeled = false
        statusText.isEditable = false
        contentView!.addSubview(statusText)
        self.statusText = statusText
        
        let cancel = NSButton(title:.local("RenameView.cancel"), target:self, action:#selector(self.cancel))
        cancel.translatesAutoresizingMaskIntoConstraints = false
        contentView!.addSubview(cancel)
        
        let save = NSButton(title:.local("RenameView.save"), target:self, action:#selector(confirm))
        save.translatesAutoresizingMaskIntoConstraints = false
        save.isEnabled = false
        contentView!.addSubview(save)
        self.save = save
        
        title.topAnchor.constraint(equalTo:contentView!.topAnchor, constant:10).isActive = true
        title.leftAnchor.constraint(equalTo:contentView!.leftAnchor, constant:10).isActive = true
        
        text.topAnchor.constraint(equalTo:title.bottomAnchor, constant:10).isActive = true
        text.leftAnchor.constraint(equalTo:title.leftAnchor).isActive = true
        text.widthAnchor.constraint(equalToConstant:240).isActive = true
        text.heightAnchor.constraint(equalToConstant:33).isActive = true
        
        status.topAnchor.constraint(equalTo:text.bottomAnchor, constant:20).isActive = true
        status.centerXAnchor.constraint(equalTo:contentView!.centerXAnchor).isActive = true
        
        statusText.topAnchor.constraint(equalTo:status.bottomAnchor, constant:10).isActive = true
        statusText.leftAnchor.constraint(equalTo:contentView!.leftAnchor, constant:10).isActive = true
        statusText.rightAnchor.constraint(equalTo:contentView!.rightAnchor, constant:-10).isActive = true
        
        cancel.bottomAnchor.constraint(equalTo:contentView!.bottomAnchor, constant:-10).isActive = true
        cancel.leftAnchor.constraint(equalTo:contentView!.leftAnchor, constant:10).isActive = true
        
        save.bottomAnchor.constraint(equalTo:contentView!.bottomAnchor, constant:-10).isActive = true
        save.rightAnchor.constraint(equalTo:contentView!.rightAnchor, constant:-10).isActive = true
    }
    
    private func stopEditing() { DispatchQueue.main.async { [weak self] in self?.makeFirstResponder(nil) } }
    
    @objc private func cancel() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.cancel)
    }
    
    @objc private func confirm() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.continue)
    }
}
