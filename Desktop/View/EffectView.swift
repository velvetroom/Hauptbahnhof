import Cocoa

class EffectView:NSPanel {
    private weak var add:NSButton!
    private weak var option:OptionView!
    private weak var presenter:Presenter!
    private weak var item:CellView? {
        willSet {
            item?.selected = false
        } didSet {
            item?.selected = true
        }
    }
    
    init(_ option:OptionView, presenter:Presenter) {
        super.init(contentRect:NSRect(x:0, y:0, width:200, height:300), styleMask:
            [.hudWindow, .utilityWindow], backing:.buffered, defer:false)
        self.option = option
        self.presenter = presenter
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
        title.stringValue = .local("EffectView.title")
        header.addSubview(title)
        
        let list = NSScrollView(frame:.zero)
        list.drawsBackground = false
        list.translatesAutoresizingMaskIntoConstraints = false
        list.hasVerticalScroller = true
        list.documentView = DocumentView()
        (list.documentView! as! DocumentView).autoLayout()
        contentView!.addSubview(list)
        
        let cancel = NSButton(title:.local("EffectView.cancel"), target:self, action:#selector(self.cancel))
        cancel.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(cancel)
        
        let add = NSButton(title:.local("EffectView.add"), target:self, action:#selector(confirm))
        add.translatesAutoresizingMaskIntoConstraints = false
        add.isEnabled = false
        footer.addSubview(add)
        self.add = add
        
        var top = list.documentView!.topAnchor
        presenter.effects.forEach { effect in
            let item = CellView(effect.rawValue)
            item.target = self
            item.action = #selector(select(item:))
            item.isEnabled = !option.option.effects.contains(effect)
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
        
        list.topAnchor.constraint(equalTo:header.bottomAnchor).isActive = true
        list.leftAnchor.constraint(equalTo:contentView!.leftAnchor).isActive = true
        list.rightAnchor.constraint(equalTo:contentView!.rightAnchor).isActive = true
        list.bottomAnchor.constraint(equalTo:footer.topAnchor).isActive = true
        
        cancel.centerYAnchor.constraint(equalTo:footer.centerYAnchor).isActive = true
        cancel.leftAnchor.constraint(equalTo:footer.leftAnchor, constant:10).isActive = true
        
        add.centerYAnchor.constraint(equalTo:footer.centerYAnchor).isActive = true
        add.rightAnchor.constraint(equalTo:footer.rightAnchor, constant:-10).isActive = true
    }
    
    @objc private func select(item:CellView) {
        self.item = item
        add.isEnabled = true
    }
    
    @objc private func cancel() {
        close()
        NSApp.stopModal()
    }
    
    @objc private func confirm() {
        presenter.addEffect(option.option, id:item!.id)
        close()
        NSApp.stopModal()
    }
}
