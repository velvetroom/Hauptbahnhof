import Cocoa
import Editor

class NextView:NSPanel {
    private weak var option:Option!
    private weak var workshop:Workshop!
    private weak var save:NSButton!
    private weak var item:NextItemView? {
        willSet {
            item?.selected = false
        } didSet {
            item?.selected = true
        }
    }
    
    init(_ option:Option, workshop:Workshop) {
        super.init(contentRect:NSRect(x:0, y:0, width:200, height:300), styleMask:
            [.hudWindow, .utilityWindow], backing:.buffered, defer:false)
        self.option = option
        self.workshop = workshop
        makeOutlets()
    }
    
    private func makeOutlets() {
        let header = NSView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.wantsLayer = true
        header.layer!.backgroundColor = NSColor.textBackgroundColor.cgColor
        contentView!.addSubview(header)
        
        let footer = NSView()
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.wantsLayer = true
        footer.layer!.backgroundColor = NSColor.textBackgroundColor.cgColor
        contentView!.addSubview(footer)
        
        let title = NSTextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize:14, weight:.bold)
        title.backgroundColor = .clear
        title.lineBreakMode = .byTruncatingTail
        title.isBezeled = false
        title.isEditable = false
        title.stringValue = .local("NextView.title")
        header.addSubview(title)
        
        let list = NSScrollView(frame:.zero)
        list.drawsBackground = false
        list.translatesAutoresizingMaskIntoConstraints = false
        list.hasVerticalScroller = true
        list.documentView = DocumentView()
        (list.documentView! as! DocumentView).autoLayout()
        contentView!.addSubview(list)
        
        let cancel = NSButton(title:.local("NextView.cancel"), target:self, action:#selector(self.cancel))
        cancel.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(cancel)
        
        let save = NSButton(title:.local("NextView.save"), target:self, action:#selector(confirm))
        save.translatesAutoresizingMaskIntoConstraints = false
        save.isEnabled = false
        footer.addSubview(save)
        self.save = save
        
        var top = list.documentView!.topAnchor
        workshop.game.messages.keys.sorted().forEach { id in
            let item = NextItemView(id)
            item.target = self
            item.action = #selector(select(item:))
            list.documentView!.addSubview(item)
            
            item.topAnchor.constraint(equalTo:top).isActive = true
            item.leftAnchor.constraint(equalTo:list.leftAnchor).isActive = true
            item.rightAnchor.constraint(equalTo:list.rightAnchor).isActive = true
            top = item.bottomAnchor
        }
        list.documentView!.bottomAnchor.constraint(equalTo:top).isActive = true
        
        header.topAnchor.constraint(equalTo:contentView!.topAnchor).isActive = true
        header.leftAnchor.constraint(equalTo:contentView!.leftAnchor).isActive = true
        header.rightAnchor.constraint(equalTo:contentView!.rightAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        footer.bottomAnchor.constraint(equalTo:contentView!.bottomAnchor).isActive = true
        footer.leftAnchor.constraint(equalTo:contentView!.leftAnchor).isActive = true
        footer.rightAnchor.constraint(equalTo:contentView!.rightAnchor).isActive = true
        footer.heightAnchor.constraint(equalToConstant:50).isActive = true
        
        title.centerYAnchor.constraint(equalTo:header.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo:header.leftAnchor, constant:10).isActive = true
        
        list.topAnchor.constraint(equalTo:title.bottomAnchor, constant:10).isActive = true
        list.leftAnchor.constraint(equalTo:contentView!.leftAnchor).isActive = true
        list.rightAnchor.constraint(equalTo:contentView!.rightAnchor).isActive = true
        list.bottomAnchor.constraint(equalTo:footer.topAnchor).isActive = true
        
        cancel.centerYAnchor.constraint(equalTo:footer.centerYAnchor).isActive = true
        cancel.leftAnchor.constraint(equalTo:footer.leftAnchor, constant:10).isActive = true
        
        save.centerYAnchor.constraint(equalTo:footer.centerYAnchor).isActive = true
        save.rightAnchor.constraint(equalTo:footer.rightAnchor, constant:-10).isActive = true
    }
    
    @objc private func select(item:NextItemView) {
        self.item = item
        save.isEnabled = true
    }
    
    @objc private func cancel() {
        close()
        NSApp.stopModal()
    }
    
    @objc private func confirm() {
        close()
        NSApp.stopModal()
    }
}
