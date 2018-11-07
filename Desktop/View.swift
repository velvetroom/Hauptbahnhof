import Cocoa

class View:NSView, NSTextFieldDelegate, NSCollectionViewDelegate, NSCollectionViewDataSource {
    private weak var collection:NSCollectionView!
    private weak var name:NSTextField!
    private var messages = [(String, Int)]()
    private let presenter = Presenter()
    
    required init?(coder:NSCoder) { return nil }
    func controlTextDidEndEditing(_:Notification) { stopEditing() }
    override func cancelOperation(_:Any?) { stopEditing() }
    override func mouseDown(with:NSEvent) { stopEditing() }
    override var mouseDownCanMoveWindow:Bool { return false }
    
    func collectionView(_:NSCollectionView, numberOfItemsInSection:Int) -> Int { return messages.count }
    
    override init(frame:NSRect) {
        super.init(frame:frame)
        makeOutlets()
        presenter.updatedTitle = { [weak self] in self?.name.stringValue = $0 }
        presenter.updatedMessages = { [weak self] in self?.messages = $0; self?.collection.reloadData() }
        presenter.load()
    }
    
    override func draw(_ rect:NSRect) {
        NSColor.clear.setFill()
        rect.fill()
    }
    
    func collectionView(_:NSCollectionView, itemForRepresentedObjectAt index:IndexPath) -> NSCollectionViewItem {
        let cell = collection.makeItem(
            withIdentifier:NSUserInterfaceItemIdentifier("cell"), for:index) as! MessageCellView
        cell.message = messages[index.item]
        return cell
    }
    
    override func viewWillStartLiveResize() {
        collection.collectionViewLayout?.invalidateLayout()
    }
    
    override func viewDidEndLiveResize() {
        collection.collectionViewLayout?.invalidateLayout()
    }
    
    private func makeOutlets() {
        let name = NSTextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize:20, weight:.light)
        name.isAutomaticTextCompletionEnabled = true
        name.lineBreakMode = .byTruncatingTail
        name.backgroundColor = .clear
        name.isBezeled = false
        name.isBordered = false
        name.placeholderString = .local("HomeView.name")
        name.delegate = self
        addSubview(name)
        self.name = name
        
        let flow = NSCollectionViewGridLayout()
        flow.maximumNumberOfColumns = 1
        flow.minimumInteritemSpacing = 2
        flow.minimumLineSpacing = 2
        flow.margins = NSEdgeInsets(top:2, left:0, bottom:2, right:2)
        flow.minimumItemSize = NSSize(width:0, height:50)
        flow.maximumItemSize = NSSize(width:0, height:50)
        
        let scroll = NSScrollView(frame:.zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scroll)
        
        let collection = NSCollectionView(frame:.zero)
        collection.collectionViewLayout = flow
        collection.isSelectable = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(MessageCellView.self, forItemWithIdentifier:NSUserInterfaceItemIdentifier("cell"))
        scroll.documentView = collection
        self.collection = collection
        
        name.topAnchor.constraint(equalTo:topAnchor, constant:20).isActive = true
        name.leftAnchor.constraint(equalTo:leftAnchor, constant:10).isActive = true
        name.rightAnchor.constraint(equalTo:rightAnchor, constant:-10).isActive = true
        
        scroll.topAnchor.constraint(equalTo:name.bottomAnchor, constant:20).isActive = true
        scroll.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        scroll.widthAnchor.constraint(equalToConstant:200).isActive = true
    }
    
    private func stopEditing() { DispatchQueue.main.async { [weak self] in self?.window?.makeFirstResponder(nil) } }
}
