import Cocoa

@NSApplicationMain class Application:NSApplication, NSApplicationDelegate {
    weak var window:NSWindow!

    override init() {
        super.init()
        delegate = self
    }
    
    required init?(coder:NSCoder) { fatalError() }
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        let window = NSWindow(contentRect:NSScreen.main!.frame, styleMask:[.titled, .resizable, .closable, .miniaturizable], backing:.buffered, defer:false)
        window.makeKeyAndOrderFront(nil)
        window.contentViewController = NSViewController(nibName:nil, bundle:nil)
        window.backgroundColor = .white
        self.window = window
    }
}
