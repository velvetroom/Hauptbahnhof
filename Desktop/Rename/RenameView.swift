import Cocoa

class RenameView:NSView {
    let presenter = RenamePresenter()
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        makeOutlets()
    }
    
    private func makeOutlets() {
        let title = NSTextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize:14, weight:.bold)
        title.backgroundColor = .clear
        title.isBezeled = false
        title.isEditable = false
        title.stringValue = .local("RenameView.title")
        addSubview(title)
        
        let text = NSTextView(frame:.zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.wantsLayer = true
        text.layer!.cornerRadius = 12
        text.textContainerInset = NSSize(width:10, height:7)
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.size = NSSize(width:240, height:33)
        text.textContainer!.lineBreakMode = .byTruncatingHead
        text.font = .systemFont(ofSize:16, weight:.light)
        text.string = presenter.id
        addSubview(text)
        
        let cancel = NSButton(title:.local("RenameView.cancel"),
                                  target:presenter, action:#selector(presenter.cancel))
        cancel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancel)
        
        title.topAnchor.constraint(equalTo:topAnchor, constant:10).isActive = true
        title.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        
        text.topAnchor.constraint(equalTo:title.bottomAnchor, constant:10).isActive = true
        text.leftAnchor.constraint(equalTo:title.leftAnchor).isActive = true
        text.widthAnchor.constraint(equalToConstant:240).isActive = true
        text.heightAnchor.constraint(equalToConstant:33).isActive = true
        
        cancel.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-10).isActive = true
        cancel.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
    }
}
