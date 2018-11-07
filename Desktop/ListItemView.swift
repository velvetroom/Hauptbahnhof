import Cocoa

class ListItemView:NSControl {
    let message:String
    override var intrinsicContentSize:NSSize { return NSSize(width:200, height:50) }
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
    
    init(message:String, options:Int) {
        self.message = message
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true

        let id = NSTextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        id.font = .systemFont(ofSize:14, weight:.medium)
        id.backgroundColor = .clear
        id.lineBreakMode = .byTruncatingTail
        id.isBezeled = false
        id.isEditable = false
        id.stringValue = message
        addSubview(id)
        
        let count = NSTextField()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.font = .systemFont(ofSize:12, weight:.light)
        count.backgroundColor = .clear
        count.lineBreakMode = .byTruncatingTail
        count.isBezeled = false
        count.isEditable = false
        count.stringValue = "+ " + String(options)
        addSubview(count)
        
        id.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        id.rightAnchor.constraint(equalTo:rightAnchor, constant:-10).isActive = true
        id.centerYAnchor.constraint(equalTo:centerYAnchor, constant:-6).isActive = true
        
        count.leftAnchor.constraint(equalTo:id.leftAnchor).isActive = true
        count.rightAnchor.constraint(equalTo:id.rightAnchor).isActive = true
        count.topAnchor.constraint(equalTo:id.bottomAnchor).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
