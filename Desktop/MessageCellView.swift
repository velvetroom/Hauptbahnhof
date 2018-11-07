import Cocoa

class MessageCellView:NSCollectionViewItem {
    var message = (String(), 0) { didSet { updatedViewModel() } }
    private weak var id:NSTextField!
    private weak var options:NSTextField!
    
    override var isSelected:Bool { didSet {
        if isSelected {
            view.layer?.backgroundColor = NSColor.selectedMenuItemColor.cgColor
        } else {
            view.layer?.backgroundColor = NSColor.underPageBackgroundColor.cgColor
        }
    } }
    
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.underPageBackgroundColor.cgColor
        
        let id = NSTextField()
        id.translatesAutoresizingMaskIntoConstraints = false
        id.font = .systemFont(ofSize:16, weight:.medium)
        id.backgroundColor = .clear
        id.lineBreakMode = .byTruncatingTail
        id.isBezeled = false
        id.isEditable = false
        view.addSubview(id)
        self.id = id
        
        let options = NSTextField()
        options.translatesAutoresizingMaskIntoConstraints = false
        options.font = .systemFont(ofSize:12, weight:.light)
        options.backgroundColor = .clear
        options.lineBreakMode = .byTruncatingTail
        options.isBezeled = false
        options.isEditable = false
        view.addSubview(options)
        self.options = options
        
        id.leftAnchor.constraint(equalTo:view.leftAnchor, constant:10).isActive = true
        id.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-10).isActive = true
        id.centerYAnchor.constraint(equalTo:view.centerYAnchor, constant:-6).isActive = true
        
        options.leftAnchor.constraint(equalTo:id.leftAnchor).isActive = true
        options.rightAnchor.constraint(equalTo:id.rightAnchor).isActive = true
        options.topAnchor.constraint(equalTo:id.bottomAnchor).isActive = true
    }
    
    private func updatedViewModel() {
        id.stringValue = message.0
        options.stringValue = "+ " + String(message.1)
    }
}
