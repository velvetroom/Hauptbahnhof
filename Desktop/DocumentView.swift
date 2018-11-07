import Cocoa

class DocumentView:NSView {
    override var isFlipped:Bool { return true }
    
    init() {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder) { return nil }
}
