import Cocoa

class DeleteView:NSView {
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
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
        addSubview(title)

        let cancel = NSButton(title:.local("DeleteView.cancel"), target:self, action:#selector(stop))
        cancel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancel)
        
        let delete = NSButton(title:.local("DeleteView.delete"), target:self, action:#selector(confirm))
        delete.translatesAutoresizingMaskIntoConstraints = false
        addSubview(delete)
        
        title.topAnchor.constraint(equalTo:topAnchor, constant:28).isActive = true
        title.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        
        cancel.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-10).isActive = true
        cancel.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        
        delete.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-10).isActive = true
        delete.rightAnchor.constraint(equalTo:rightAnchor, constant:-10).isActive = true
    }
    
    @objc private func stop() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.cancel)
    }
    
    @objc private func confirm() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.continue)
    }
}
