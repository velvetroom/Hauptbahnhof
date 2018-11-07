import Cocoa

class DocumentView:NSView {
    override var isFlipped:Bool { return true }
    
    func autoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo:superview!.topAnchor).isActive = true
        leftAnchor.constraint(equalTo:superview!.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo:superview!.rightAnchor).isActive = true
    }
}
