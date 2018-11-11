import Cocoa
import Editor

class ItemView:NSControl {
    weak var message:Message!
    var id = String() { didSet { name.stringValue = id } }
    private weak var name:NSTextField!
    override var intrinsicContentSize:NSSize { return NSSize(width:200, height:50) }
    var selected = false { didSet {
        if selected {
            layer!.backgroundColor = NSColor.selectedMenuItemColor.cgColor
        } else {
            layer!.backgroundColor = NSColor.clear.cgColor
        }
    } }
    
    override func mouseDown(with:NSEvent) {
        if !selected {
            sendAction(action, to:target)
        }
    }
    
    init(_ message:Message) {
        self.message = message
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        wantsLayer = true

        let name = NSTextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize:14, weight:.medium)
        name.backgroundColor = .clear
        name.lineBreakMode = .byTruncatingTail
        name.isBezeled = false
        name.isEditable = false
        addSubview(name)
        self.name = name
        
        let count = NSTextField()
        count.translatesAutoresizingMaskIntoConstraints = false
        count.font = .systemFont(ofSize:12, weight:.light)
        count.backgroundColor = .clear
        count.lineBreakMode = .byTruncatingTail
        count.isBezeled = false
        count.isEditable = false
        count.stringValue = "+ " + String(message.options.count)
        addSubview(count)
        
        name.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        name.rightAnchor.constraint(equalTo:rightAnchor, constant:-10).isActive = true
        name.centerYAnchor.constraint(equalTo:centerYAnchor, constant:-6).isActive = true
        
        count.leftAnchor.constraint(equalTo:name.leftAnchor).isActive = true
        count.rightAnchor.constraint(equalTo:name.rightAnchor).isActive = true
        count.topAnchor.constraint(equalTo:name.bottomAnchor).isActive = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
