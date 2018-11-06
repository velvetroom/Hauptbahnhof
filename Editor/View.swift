import Cocoa

class View:NSView {
    override init(frame:NSRect) {
        super.init(frame:frame)
        loadData()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func draw(_ rect:NSRect) {
        NSColor.black.setFill()
        rect.fill()
    }
    
    private func loadData() {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:"One", withExtension:"json")!)
        let game = try! JSONDecoder().decode(Game.self, from:data)
        print(game)
    }
}
