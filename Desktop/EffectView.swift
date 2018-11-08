import Cocoa

class EffectView:NSControl {
    let effect:String
    override var intrinsicContentSize:NSSize { return NSSize(width:200, height:30) }
    var selected = false { didSet {
        if selected {
            layer!.backgroundColor = NSColor.selectedMenuItemColor.cgColor
        } else {
            layer!.backgroundColor = NSColor.clear.cgColor
        }
    } }
    
    override func mouseDown(with:NSEvent) {
        sendAction(action, to:target)
    }
    
    init(_ effect:String) {
        self.effect = effect
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true
        
        let id = NSTextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        id.font = .systemFont(ofSize:14, weight:.light)
        id.backgroundColor = .clear
        id.lineBreakMode = .byTruncatingTail
        id.isBezeled = false
        id.isEditable = false
        id.stringValue = effect
        addSubview(id)
        
        id.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        id.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
