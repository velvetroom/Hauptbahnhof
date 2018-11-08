import Cocoa
import Editor

class OptionView:NSView {
    override var intrinsicContentSize:NSSize { return NSSize(width:NSView.noIntrinsicMetric, height:150) }
    
    init(_ option:Option, messages:[String]) {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let text = NSTextView(frame:.zero)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.wantsLayer = true
        text.layer!.cornerRadius = 12
        text.textContainerInset = NSSize(width:20, height:10)
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.size = NSSize(width:350, height:52)
        text.textContainer!.lineBreakMode = .byTruncatingTail
        text.font = NSFont.systemFont(ofSize:16, weight:.light)
        text.string = option.text
        addSubview(text)
        
        let nextTitle = NSTextField()
        nextTitle.translatesAutoresizingMaskIntoConstraints = false
        nextTitle.font = .systemFont(ofSize:12, weight:.medium)
        nextTitle.backgroundColor = .clear
        nextTitle.lineBreakMode = .byTruncatingTail
        nextTitle.isBezeled = false
        nextTitle.isEditable = false
        nextTitle.stringValue = .local("OptionView.next")
        addSubview(nextTitle)
        
        let next = NSPopUpButton(frame:.zero)
        next.translatesAutoresizingMaskIntoConstraints = false
        next.addItems(withTitles:messages)
        next.selectItem(withTitle:option.next)
        addSubview(next)

        text.topAnchor.constraint(equalTo:topAnchor, constant:6).isActive = true
        text.leftAnchor.constraint(equalTo:leftAnchor, constant:-10).isActive = true
        text.widthAnchor.constraint(equalToConstant:350).isActive = true
        text.heightAnchor.constraint(equalToConstant:52).isActive = true
        
        nextTitle.centerYAnchor.constraint(equalTo:next.centerYAnchor).isActive = true
        nextTitle.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        
        next.topAnchor.constraint(equalTo:text.bottomAnchor, constant:10).isActive = true
        next.leftAnchor.constraint(equalTo:nextTitle.rightAnchor, constant:10).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
