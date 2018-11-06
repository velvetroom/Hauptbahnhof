import Cocoa

class HomeView:NSView, NSTextFieldDelegate, NSCollectionViewDelegate, NSCollectionViewDataSource {
    private weak var collection:NSCollectionView!
    private weak var name:NSTextField!
    private var items = [HomeItem]()
    private let presenter = HomePresenter()
    
    required init?(coder:NSCoder) { return nil }
    func controlTextDidEndEditing(_:Notification) { stopEditing() }
    override func cancelOperation(_:Any?) { stopEditing() }
    override func mouseDown(with event: NSEvent) { stopEditing() }
    func collectionView(_:NSCollectionView, numberOfItemsInSection:Int) -> Int { return items.count }
    
    override init(frame:NSRect) {
        super.init(frame:frame)
        makeOutlets()
        presenter.update = { [weak self] in self?.update(viewModel:$0) }
        presenter.load()
    }
    
    override func draw(_ rect:NSRect) {
        NSColor.windowBackgroundColor.setFill()
        rect.fill()
    }

    func collectionView(_:NSCollectionView, itemForRepresentedObjectAt index:IndexPath) -> NSCollectionViewItem {
        return collection.makeItem(withIdentifier:NSUserInterfaceItemIdentifier("cell"), for:index)
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
        name.backgroundColor = .windowBackgroundColor
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
        flow.margins = NSEdgeInsets(top:2, left:0, bottom:2, right:0)
        flow.minimumItemSize = NSSize(width:0, height:70)
        flow.maximumItemSize = NSSize(width:0, height:70)
        
        let collection = NSCollectionView(frame:.zero)
        collection.collectionViewLayout = flow
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(HomeCellView.self, forItemWithIdentifier:NSUserInterfaceItemIdentifier("cell"))
        addSubview(collection)
        self.collection = collection
        
        name.topAnchor.constraint(equalTo:topAnchor, constant:20).isActive = true
        name.leftAnchor.constraint(equalTo:leftAnchor, constant:20).isActive = true
        name.rightAnchor.constraint(equalTo:rightAnchor, constant:-20).isActive = true
        
        collection.topAnchor.constraint(equalTo:name.bottomAnchor, constant:20).isActive = true
        collection.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
    }
    
    private func update(viewModel:Home) {
        name.stringValue = viewModel.name
        items = viewModel.items
        collection.reloadData()
    }
    
    private func stopEditing() { DispatchQueue.main.async { [weak self] in self?.window?.makeFirstResponder(nil) } }
}
