import Cocoa
import Editor

class OptionView:NSView {
    private(set) weak var option:Option!
    private(set) weak var edit:NSButton!
    private(set) weak var show:NSButton!
    private weak var list:NSScrollView!
    override var intrinsicContentSize:NSSize { return NSSize(width:NSView.noIntrinsicMetric, height:150) }
    
    init(_ option:Option) {
        self.option = option
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let text = NSTextView(frame:.zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.wantsLayer = true
        text.layer!.cornerRadius = 12
        text.textContainerInset = NSSize(width:20, height:7)
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.size = NSSize(width:350, height:52)
        text.textContainer!.lineBreakMode = .byTruncatingTail
        text.font = .systemFont(ofSize:16, weight:.light)
        text.string = option.text
        addSubview(text)
        
        let edit = NSButton(title:.local("OptionView.edit"), target:nil, action:nil)
        edit.translatesAutoresizingMaskIntoConstraints = false
        addSubview(edit)
        self.edit = edit
        
        let next = NSTextField()
        next.translatesAutoresizingMaskIntoConstraints = false
        next.font = .systemFont(ofSize:12, weight:.medium)
        next.backgroundColor = .clear
        next.lineBreakMode = .byTruncatingTail
        next.isBezeled = false
        next.isEditable = false
        next.stringValue = .local("OptionView.next")
        addSubview(next)
        
        let show = NSButton(title:option.next, target:nil, action:nil)
        show.translatesAutoresizingMaskIntoConstraints = false
        show.isHidden = option.next.isEmpty
        addSubview(show)
        self.show = show
        
        let list = NSScrollView(frame:.zero)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.hasVerticalScroller = true
        list.wantsLayer = true
        list.layer!.cornerRadius = 12
        list.documentView = DocumentView()
        (list.documentView! as! DocumentView).autoLayout()
        addSubview(list)
        self.list = list
        
        let buttonAdd = ButtonView("add")
        addSubview(buttonAdd)

        text.topAnchor.constraint(equalTo:topAnchor, constant:6).isActive = true
        text.leftAnchor.constraint(equalTo:leftAnchor, constant:-10).isActive = true
        text.widthAnchor.constraint(equalToConstant:350).isActive = true
        text.heightAnchor.constraint(equalToConstant:52).isActive = true
        
        edit.topAnchor.constraint(equalTo:text.bottomAnchor, constant:10).isActive = true
        edit.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        
        next.centerYAnchor.constraint(equalTo:edit.centerYAnchor).isActive = true
        next.leftAnchor.constraint(equalTo:edit.rightAnchor, constant:10).isActive = true
        
        show.centerYAnchor.constraint(equalTo:edit.centerYAnchor).isActive = true
        show.leftAnchor.constraint(equalTo:next.rightAnchor, constant:10).isActive = true
        
        list.topAnchor.constraint(equalTo:text.topAnchor).isActive = true
        list.leftAnchor.constraint(equalTo:text.rightAnchor, constant:10).isActive = true
        list.widthAnchor.constraint(equalToConstant:300).isActive = true
        list.heightAnchor.constraint(equalToConstant:90).isActive = true
        
        buttonAdd.topAnchor.constraint(equalTo:list.topAnchor).isActive = true
        buttonAdd.leftAnchor.constraint(equalTo:list.rightAnchor, constant:10).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
