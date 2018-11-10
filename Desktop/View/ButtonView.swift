import Cocoa

class ButtonView:NSButton {
    override var intrinsicContentSize:NSSize { return image!.size }
    override func mouseDown(with event:NSEvent) {
        contentTintColor = NSColor.selectedMenuItemColor
    }
    
    override func mouseUp(with event:NSEvent) {
        contentTintColor = NSColor.controlColor
    }
    
    init(_ image:String) {
        super.init(frame:.zero)
        self.image = NSImage(named:image)
        self.image?.isTemplate = true
        translatesAutoresizingMaskIntoConstraints = false
        imageScaling = .scaleNone
        isBordered = false
        contentTintColor = NSColor.controlColor
    }
    
    required init?(coder:NSCoder) { return nil }
}
