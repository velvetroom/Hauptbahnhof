import Cocoa

class ButtonView:NSButton {
    override var intrinsicContentSize:NSSize { return image!.size }
    override func mouseDown(with event:NSEvent) {
        if isEnabled {
            contentTintColor = .selectedMenuItemColor
        }
    }
    
    override func mouseUp(with event:NSEvent) {
        if isEnabled {
            contentTintColor = .controlColor
            sendAction(action, to:target)
        }
    }
    
    init(_ image:String) {
        super.init(frame:.zero)
        self.image = NSImage(named:image)
        self.image?.isTemplate = true
        translatesAutoresizingMaskIntoConstraints = false
        imageScaling = .scaleNone
        isBordered = false
        contentTintColor = .controlColor
    }
    
    required init?(coder:NSCoder) { return nil }
}
