import Cocoa

class DeleteView:NSWindow {
    init() {
        super.init(contentRect:NSRect(x:0, y:0, width:200, height:100), styleMask:.titled, backing:.buffered,
                   defer:false)
        makeOutlets()
    }
    
    private func makeOutlets() {
        let title = NSTextField()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize:15, weight:.medium)
        title.backgroundColor = .clear
        title.isBezeled = false
        title.isEditable = false
        title.alignment = .center
        title.stringValue = .local("DeleteView.title")
        contentView!.addSubview(title)

        let cancel = NSButton(title:.local("DeleteView.cancel"), target:self, action:#selector(self.cancel))
        cancel.translatesAutoresizingMaskIntoConstraints = false
        contentView!.addSubview(cancel)

        let delete = NSButton(title:.local("DeleteView.delete"), target:self, action:#selector(self.delete))
        delete.translatesAutoresizingMaskIntoConstraints = false
        contentView!.addSubview(delete)

        title.topAnchor.constraint(equalTo:contentView!.topAnchor, constant:28).isActive = true
        title.centerXAnchor.constraint(equalTo:contentView!.centerXAnchor).isActive = true

        cancel.bottomAnchor.constraint(equalTo:contentView!.bottomAnchor, constant:-10).isActive = true
        cancel.leftAnchor.constraint(equalTo:contentView!.leftAnchor, constant:10).isActive = true

        delete.bottomAnchor.constraint(equalTo:contentView!.bottomAnchor, constant:-10).isActive = true
        delete.rightAnchor.constraint(equalTo:contentView!.rightAnchor, constant:-10).isActive = true
    }
    
    @objc private func cancel() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.cancel)
    }
    
    @objc private func delete() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.continue)
    }
}
