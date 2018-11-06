import Cocoa

class HomeCellView:NSCollectionViewItem {
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
    }
}
