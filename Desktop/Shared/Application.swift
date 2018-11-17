import Cocoa
import Editor

@NSApplicationMain class Application:NSObject, NSApplicationDelegate {
    private(set) static weak var window:NSWindow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        injection()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_:NSApplication) -> Bool { return true }
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        Application.window = NSApp.windows.first
        Application.window.isOpaque = false
        Application.window.backgroundColor = NSColor.windowBackgroundColor.withAlphaComponent(0.9)
    }
    
    private func injection() {
        Factory.storage = Session.self
    }
}
