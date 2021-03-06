import Cocoa

class CellView:NSControl {
    let id:String
    override var intrinsicContentSize:NSSize { return NSSize(width:NSView.noIntrinsicMetric, height:30) }
    override var isEnabled:Bool { didSet {
        if isEnabled {
            alphaValue = 1
        } else {
            alphaValue = 0.25
        }
    } }
    var selected = false { didSet {
        if selected {
            layer!.backgroundColor = NSColor.selectedMenuItemColor.cgColor
        } else {
            layer!.backgroundColor = NSColor.clear.cgColor
        }
    } }
    
    override func mouseDown(with:NSEvent) {
        if !selected && isEnabled {
            sendAction(action, to:target)
        }
    }
    
    init(_ id:String) {
        self.id = id
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        
        let name = NSTextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize:13, weight:.medium)
        name.backgroundColor = .clear
        name.lineBreakMode = .byTruncatingTail
        name.isBezeled = false
        name.isEditable = false
        name.stringValue = id
        addSubview(name)
        
        name.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        name.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        name.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
