import Cocoa
import Editor

class View:NSView, NSTextViewDelegate {
    private weak var list:NSScrollView!
    private weak var options:NSScrollView!
    private weak var text:NSTextView!
    private weak var chapter:NSTextView!
    private weak var status:NSImageView!
    private weak var statusText:NSTextField!
    private weak var rename:NSButton!
    private weak var delete:NSButton!
    private weak var editionArea:NSView!
    private let presenter = Presenter()

    override func cancelOperation(_:Any?) { stopEditing() }
    override func mouseDown(with:NSEvent) { stopEditing() }
    
    override func viewDidEndLiveResize() {
        super.viewDidEndLiveResize()
        text.textContainer!.size = NSSize(width:options.bounds.width - 20, height:.greatestFiniteMagnitude)
    }
    
    func textView(_ text:NSTextView, doCommandBy selector:Selector) -> Bool {
        if text === chapter && (selector == #selector(NSResponder.insertNewline(_:))) {
            stopEditing()
            return true
        }
        return false
    }
    
    func textDidChange(_ notification:Notification) {
        let text = notification.object as! NSTextView
        if text === self.text {
            presenter.update(text:text.string)
        }
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        makeOutlets()
        presenter.viewModel.title = { self.chapter.string = $0 }
        presenter.viewModel.messages = { self.reload($0) }
        presenter.viewModel.shouldSelect = { self.select(id:$0) }
        presenter.viewModel.status = {
            self.status.image = $0.image
            self.statusText.stringValue = $0.message
        }
        presenter.viewModel.item = {
            if let item = $0 {
                self.text.string = item.message.text
                self.reloadOptions(item.message)
                self.editionArea.isHidden = false
                self.rename.isEnabled = true
                self.delete.isEnabled = true
            } else {
                self.editionArea.isHidden = true
                self.rename.isEnabled = false
                self.delete.isEnabled = false
            }
        }
        presenter.load()
    }
    
    private func makeOutlets() {
        let bar = NSView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.wantsLayer = true
        bar.layer!.backgroundColor = NSColor.windowBackgroundColor.cgColor
        addSubview(bar)
        
        let chapter = NSTextView(frame:.zero)
        chapter.translatesAutoresizingMaskIntoConstraints = false
        chapter.drawsBackground = false
        chapter.textContainer!.lineBreakMode = .byTruncatingHead
        chapter.textContainerInset = NSSize(width:10, height:10)
        chapter.isContinuousSpellCheckingEnabled = true
        chapter.textContainer!.size = NSSize(width:600, height:30)
        chapter.font = .systemFont(ofSize:14, weight:.light)
        chapter.delegate = self
        bar.addSubview(chapter)
        self.chapter = chapter
        
        let addMessage = NSButton(title:.local("View.addMessage"),
                                  target:presenter, action:#selector(presenter.addMessage))
        addMessage.translatesAutoresizingMaskIntoConstraints = false
        bar.addSubview(addMessage)
        
        let rename = NSButton(title:.local("View.rename"), target:presenter, action:#selector(presenter.rename))
        rename.translatesAutoresizingMaskIntoConstraints = false
        rename.isEnabled = false
        bar.addSubview(rename)
        self.rename = rename
        
        let delete = NSButton(title:.local("View.delete"), target:presenter, action:#selector(presenter.delete))
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.isEnabled = false
        bar.addSubview(delete)
        self.delete = delete
        
        let status = NSImageView(frame:.zero)
        status.isEnabled = false
        status.imageScaling = .scaleNone
        status.contentTintColor = .selectedMenuItemColor
        status.translatesAutoresizingMaskIntoConstraints = false
        bar.addSubview(status)
        self.status = status
        
        let statusText = NSTextField()
        statusText.translatesAutoresizingMaskIntoConstraints = false
        statusText.font = .systemFont(ofSize:11, weight:.light)
        statusText.backgroundColor = .clear
        statusText.alignment = .right
        statusText.isBezeled = false
        statusText.isEditable = false
        bar.addSubview(statusText)
        self.statusText = statusText
        
        let list = NSScrollView(frame:.zero)
        list.drawsBackground = false
        list.translatesAutoresizingMaskIntoConstraints = false
        list.hasVerticalScroller = true
        list.documentView = DocumentView()
        (list.documentView! as! DocumentView).autoLayout()
        addSubview(list)
        self.list = list
        
        let editionArea = NSView()
        editionArea.translatesAutoresizingMaskIntoConstraints = false
        editionArea.wantsLayer = true
        editionArea.isHidden = true
        editionArea.layer!.backgroundColor = NSColor.windowBackgroundColor.cgColor
        addSubview(editionArea)
        self.editionArea = editionArea
        
        let scrollText = NSScrollView(frame:.zero)
        scrollText.translatesAutoresizingMaskIntoConstraints = false
        scrollText.hasVerticalScroller = true
        editionArea.addSubview(scrollText)
        
        let text = NSTextView(frame:.zero)
        text.textContainerInset = NSSize(width:10, height:10)
        text.isVerticallyResizable = true
        text.isHorizontallyResizable = true
        text.isContinuousSpellCheckingEnabled = true
        text.font = .systemFont(ofSize:16, weight:.light)
        text.delegate = self
        scrollText.documentView = text
        self.text = text
        
        let options = NSScrollView(frame:.zero)
        options.drawsBackground = false
        options.translatesAutoresizingMaskIntoConstraints = false
        options.hasVerticalScroller = true
        options.documentView = DocumentView()
        (options.documentView! as! DocumentView).autoLayout()
        editionArea.addSubview(options)
        self.options = options
        
        bar.topAnchor.constraint(equalTo:topAnchor).isActive = true
        bar.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        bar.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        bar.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        list.topAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        list.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        list.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        list.widthAnchor.constraint(equalToConstant:200).isActive = true
        
        chapter.topAnchor.constraint(equalTo:bar.topAnchor, constant:20).isActive = true
        chapter.leftAnchor.constraint(equalTo:bar.leftAnchor).isActive = true
        chapter.bottomAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        chapter.widthAnchor.constraint(equalToConstant:220).isActive = true
        
        addMessage.centerYAnchor.constraint(equalTo:chapter.centerYAnchor).isActive = true
        addMessage.leftAnchor.constraint(equalTo:chapter.rightAnchor, constant:10).isActive = true
        
        rename.centerYAnchor.constraint(equalTo:chapter.centerYAnchor).isActive = true
        rename.leftAnchor.constraint(equalTo:addMessage.rightAnchor, constant:10).isActive = true
        
        delete.centerYAnchor.constraint(equalTo:chapter.centerYAnchor).isActive = true
        delete.leftAnchor.constraint(equalTo:rename.rightAnchor, constant:10).isActive = true
        
        status.centerYAnchor.constraint(equalTo:chapter.centerYAnchor).isActive = true
        status.rightAnchor.constraint(equalTo:bar.rightAnchor, constant:-6).isActive = true
        
        statusText.topAnchor.constraint(equalTo:bar.topAnchor, constant:5).isActive = true
        statusText.rightAnchor.constraint(equalTo:bar.rightAnchor, constant:-5).isActive = true
        
        editionArea.topAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        editionArea.leftAnchor.constraint(equalTo:list.rightAnchor).isActive = true
        editionArea.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        editionArea.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        
        scrollText.topAnchor.constraint(equalTo:editionArea.topAnchor).isActive = true
        scrollText.leftAnchor.constraint(equalTo:editionArea.leftAnchor).isActive = true
        scrollText.rightAnchor.constraint(equalTo:editionArea.rightAnchor).isActive = true
        scrollText.heightAnchor.constraint(equalToConstant:200).isActive = true
        
        options.topAnchor.constraint(equalTo:scrollText.bottomAnchor).isActive = true
        options.leftAnchor.constraint(equalTo:editionArea.leftAnchor).isActive = true
        options.rightAnchor.constraint(equalTo:editionArea.rightAnchor).isActive = true
        options.bottomAnchor.constraint(equalTo:editionArea.bottomAnchor).isActive = true
    }
    
    private func stopEditing() { DispatchQueue.main.async { [weak self] in self?.window?.makeFirstResponder(nil) } }
    
    private func reload(_ messages:[String:Message]) {
        list.documentView!.subviews.forEach { $0.removeFromSuperview() }
        var top = list.documentView!.topAnchor
        messages.keys.sorted().forEach { id in
            let item = ItemView(messages[id]!)
            item.id = id
            item.target = self
            item.action = #selector(select(item:))
            list.documentView!.addSubview(item)
            
            item.topAnchor.constraint(equalTo:top).isActive = true
            item.leftAnchor.constraint(equalTo:list.leftAnchor).isActive = true
            top = item.bottomAnchor
        }
        list.documentView!.bottomAnchor.constraint(equalTo:top).isActive = true
    }
    
    private func reloadOptions(_ message:Message) {
        options.documentView!.subviews.forEach { $0.removeFromSuperview() }
        var top = options.documentView!.topAnchor
        message.options.forEach { item in
            let option = OptionView(item)
            option.edit.target = presenter
            option.edit.action = #selector(presenter.edit(next:))
            options.documentView!.addSubview(option)
            
            option.topAnchor.constraint(equalTo:top).isActive = true
            option.leftAnchor.constraint(equalTo:options.leftAnchor).isActive = true
            option.rightAnchor.constraint(equalTo:options.rightAnchor).isActive = true
            top = option.bottomAnchor
        }
        if !message.options.isEmpty {
            options.documentView!.bottomAnchor.constraint(equalTo:top).isActive = true
        }
    }
    
    private func select(id:String) {
        list.documentView!.subviews.forEach {
            if ($0 as! ItemView).id == id {
                select(item:($0 as! ItemView))
                list.contentView.scrollToVisible($0.frame)
            }
        }
    }
    
    @objc private func select(item:ItemView) {
        presenter.viewModel.selected = item
    }
}
