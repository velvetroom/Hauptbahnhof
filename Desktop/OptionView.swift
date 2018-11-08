import Cocoa
import Editor

class OptionView:NSView {
    override var intrinsicContentSize:NSSize { return NSSize(width:NSView.noIntrinsicMetric, height:150) }
    
    init(_ option:Option, messages:[String]) {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let scrollText = NSScrollView(frame:.zero)
        scrollText.translatesAutoresizingMaskIntoConstraints = false
        scrollText.wantsLayer = true
        scrollText.layer?.cornerRadius = 12
        addSubview(scrollText)
        
        let text = NSTextView(frame:.zero)
        text.textContainerInset = NSSize(width:20, height:10)
        text.isVerticallyResizable = true
        text.isHorizontallyResizable = true
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.widthTracksTextView = true
        text.textContainer!.heightTracksTextView = true
        text.font = NSFont.systemFont(ofSize:16, weight:.light)
        text.string = option.text
        scrollText.documentView = text
        
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

        scrollText.topAnchor.constraint(equalTo:topAnchor, constant:6).isActive = true
        scrollText.leftAnchor.constraint(equalTo:leftAnchor, constant:-10).isActive = true
        scrollText.widthAnchor.constraint(equalToConstant:350).isActive = true
        scrollText.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        nextTitle.centerYAnchor.constraint(equalTo:next.centerYAnchor).isActive = true
        nextTitle.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        
        next.topAnchor.constraint(equalTo:scrollText.bottomAnchor, constant:10).isActive = true
        next.leftAnchor.constraint(equalTo:nextTitle.rightAnchor, constant:10).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
