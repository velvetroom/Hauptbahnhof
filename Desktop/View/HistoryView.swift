import Cocoa

class HistoryView:NSView {
    weak var presenter:Presenter!
    private var items = [String]()
    
    init() {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func add(_ item:String) {
        guard
            item.isEmpty == false,
            !items.contains(item)
        else { return }
        if items.count > 7 {
            items.removeFirst()
        }
        items.append(item)
        update()
    }
    
    private func update() {
        subviews.forEach { $0.removeFromSuperview() }
        var left = leftAnchor
        items.forEach { item in
            let button = NSButton(title:item, target:presenter, action:#selector(presenter.history(button:)))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isBordered = false
            addSubview(button)
            
            button.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
            button.leftAnchor.constraint(equalTo:left, constant:10).isActive = true
            left = button.rightAnchor
        }
    }
}
