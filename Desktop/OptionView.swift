import Cocoa
import Editor

class OptionView:NSView {
    private weak var text:NSText!
    override var intrinsicContentSize:NSSize { return NSSize(width:NSView.noIntrinsicMetric, height:150) }
    
    init(_ option:Option) {
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
        text.textContainer!.heightTracksTextView = false
        text.font = NSFont.systemFont(ofSize:16, weight:.light)
        text.string = option.text
        scrollText.documentView = text
        self.text = text

        scrollText.topAnchor.constraint(equalTo:topAnchor, constant:6).isActive = true
        scrollText.leftAnchor.constraint(equalTo:leftAnchor, constant:-10).isActive = true
        scrollText.rightAnchor.constraint(equalTo:rightAnchor, constant:-140).isActive = true
        scrollText.heightAnchor.constraint(equalToConstant:60).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
