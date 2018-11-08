import Cocoa
import Editor

class View:NSView, NSTextViewDelegate {
    private weak var list:NSScrollView!
    private weak var options:NSScrollView!
    private weak var text:NSTextView!
    private weak var chapter:NSTextView!
    private var messages = [String:Message]() { didSet { reloadList() } }
    private let presenter = Presenter()

    override func cancelOperation(_:Any?) { stopEditing() }
    override func mouseDown(with:NSEvent) { stopEditing() }
    override var mouseDownCanMoveWindow:Bool { return false }
    
    func textView(_:NSTextView, doCommandBy selector:Selector) -> Bool {
        if (selector == #selector(NSResponder.insertNewline(_:))) {
            stopEditing()
            return true
        }
        return false
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        makeOutlets()
        presenter.updatedTitle = { [weak self] in self?.chapter.string = $0 }
        presenter.updated = { [weak self] in self?.messages = $0 }
        presenter.load()
    }
    
    private func makeOutlets() {
        let scrollChapter = NSScrollView(frame:.zero)
        scrollChapter.drawsBackground = false
        scrollChapter.translatesAutoresizingMaskIntoConstraints = false
        scrollChapter.hasHorizontalScroller = true
        addSubview(scrollChapter)
        
        let chapter = NSTextView(frame:.zero)
        chapter.drawsBackground = false
        chapter.textContainerInset = NSSize(width:10, height:20)
        chapter.isHorizontallyResizable = true
        chapter.isVerticallyResizable = true
        chapter.isContinuousSpellCheckingEnabled = true
        chapter.textContainer!.widthTracksTextView = true
        chapter.textContainer!.heightTracksTextView = true
        chapter.font = NSFont.systemFont(ofSize:14, weight:.light)
        chapter.delegate = self
        scrollChapter.documentView = chapter
        self.chapter = chapter
        
        let flow = NSCollectionViewGridLayout()
        flow.maximumNumberOfColumns = 1
        flow.minimumInteritemSpacing = 2
        flow.minimumLineSpacing = 2
        flow.margins = NSEdgeInsets(top:2, left:0, bottom:2, right:2)
        flow.minimumItemSize = NSSize(width:0, height:50)
        flow.maximumItemSize = NSSize(width:0, height:50)
        
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
        editionArea.layer!.backgroundColor = NSColor.underPageBackgroundColor.cgColor
        addSubview(editionArea)
        
        let scrollText = NSScrollView(frame:.zero)
        scrollText.translatesAutoresizingMaskIntoConstraints = false
        scrollText.hasVerticalScroller = true
        editionArea.addSubview(scrollText)
        
        let text = NSTextView(frame:.zero)
        text.textContainerInset = NSSize(width:10, height:10)
        text.isVerticallyResizable = true
        text.isHorizontallyResizable = true
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.widthTracksTextView = true
        text.textContainer!.heightTracksTextView = false
        text.font = NSFont.systemFont(ofSize:16, weight:.light)
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
        
        list.topAnchor.constraint(equalTo:chapter.bottomAnchor).isActive = true
        list.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        list.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        list.widthAnchor.constraint(equalToConstant:200).isActive = true
        
        scrollChapter.topAnchor.constraint(equalTo:topAnchor).isActive = true
        scrollChapter.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        scrollChapter.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        scrollChapter.heightAnchor.constraint(equalToConstant:52).isActive = true
        
        editionArea.topAnchor.constraint(equalTo:chapter.bottomAnchor).isActive = true
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
    
    private func reloadList() {
        list.documentView!.subviews.forEach { $0.removeFromSuperview() }
        var top = list.documentView!.topAnchor
        messages.forEach { id, message in
            let item = ItemView(id, options:message.options.count)
            item.target = self
            item.action = #selector(select(item:))
            list.documentView!.addSubview(item)
            
            item.topAnchor.constraint(equalTo:top).isActive = true
            item.leftAnchor.constraint(equalTo:list.leftAnchor).isActive = true
            top = item.bottomAnchor
        }
        list.documentView!.bottomAnchor.constraint(equalTo:top).isActive = true
    }
    
    private func reloadOption(items:[Option]) {
        options.documentView!.subviews.forEach { $0.removeFromSuperview() }
        var top = options.documentView!.topAnchor
        items.forEach { item in
            let option = OptionView(item, messages:Array(messages.keys))
            options.documentView!.addSubview(option)
            
            option.topAnchor.constraint(equalTo:top).isActive = true
            option.leftAnchor.constraint(equalTo:options.leftAnchor).isActive = true
            option.rightAnchor.constraint(equalTo:options.rightAnchor).isActive = true
            top = option.bottomAnchor
        }
        options.documentView!.bottomAnchor.constraint(equalTo:top).isActive = true
    }
    
    @objc private func select(item:ItemView) {
        list.documentView!.subviews.forEach { ($0 as! ItemView).selected = $0 === item }
        text.string = messages[item.message]!.text
        reloadOption(items:messages[item.message]!.options)
    }
}
