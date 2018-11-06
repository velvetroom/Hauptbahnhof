import Cocoa

@NSApplicationMain class Application:NSApplication, NSApplicationDelegate {
    override init() {
        super.init()
        delegate = self
    }
    
    required init?(coder:NSCoder) { fatalError() }
    func applicationShouldTerminateAfterLastWindowClosed(_:NSApplication) -> Bool { return true }
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        let menu = NSMenu()
        let submenu = NSMenu()
        submenu.addItem(withTitle:.local("Application.quit"), action:#selector(quit), keyEquivalent:"q")
        menu.addItem(withTitle:String(), action:nil, keyEquivalent:String()).submenu = submenu
        self.mainMenu = menu
        
        let rect = NSRect(x:(NSScreen.main!.frame.width - 800) / 2, y:
            (NSScreen.main!.frame.height - 800) / 2, width:800, height:800)
        let window = NSWindow(contentRect:rect, styleMask:
            [.titled, .resizable, .closable, .miniaturizable], backing:.buffered, defer:false)
        window.makeKeyAndOrderFront(nil)
        window.contentView = View()
        window.backgroundColor = .white
    }
    
    @objc private func quit() { terminate(nil) }
}
