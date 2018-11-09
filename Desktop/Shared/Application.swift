import Cocoa
import Editor

@NSApplicationMain class Application:NSApplication, NSApplicationDelegate {
    private(set) static weak var window:NSWindow!
    
    override init() {
        super.init()
        delegate = self
        injection()
    }
    
    required init?(coder:NSCoder) { fatalError() }
    
    func applicationShouldTerminateAfterLastWindowClosed(_:NSApplication) -> Bool { return true }
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        let menu = NSMenu()
        let submenu = NSMenu()
        submenu.addItem(withTitle:.local("Application.quit"), action:#selector(quit), keyEquivalent:"q")
        menu.addItem(withTitle:String(), action:nil, keyEquivalent:String()).submenu = submenu
        self.mainMenu = menu
        
        let rect = NSRect(x:(NSScreen.main!.frame.width - 1000) / 2, y:
            (NSScreen.main!.frame.height - 800) / 2, width:1000, height:800)
        let window = NSWindow(contentRect:rect, styleMask:
            [.titled, .resizable, .closable, .miniaturizable, .fullSizeContentView], backing:.buffered, defer:false)
        window.makeKeyAndOrderFront(nil)
        window.isOpaque = false
        window.titlebarAppearsTransparent = true
        window.backgroundColor = NSColor.windowBackgroundColor.withAlphaComponent(0.9)
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.contentView = EditorView()
        window.isReleasedWhenClosed = false
        Application.window = window
    }
    
    private func injection() {
        Factory.storage = Session.self
    }
    
    @objc private func quit() { terminate(nil) }
}
