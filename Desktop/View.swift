import Cocoa

class View:NSView, NSTextViewDelegate, NSCollectionViewDelegate, NSCollectionViewDataSource {
    private weak var list:NSCollectionView!
    private weak var text:NSTextView!
    private weak var chapter:NSTextView!
    private var messages = [(String, Int)]()
    private let presenter = Presenter()

    override func cancelOperation(_:Any?) { stopEditing() }
    override func mouseDown(with:NSEvent) { stopEditing() }
    override var mouseDownCanMoveWindow:Bool { return false }
    
    func collectionView(_:NSCollectionView, numberOfItemsInSection:Int) -> Int { return messages.count }
    
    func collectionView(_:NSCollectionView, itemForRepresentedObjectAt index:IndexPath) -> NSCollectionViewItem {
        let cell = list.makeItem(withIdentifier:NSUserInterfaceItemIdentifier("cell"), for:index) as! MessageCellView
        cell.message = messages[index.item]
        return cell
    }
    
    func collectionView(_:NSCollectionView, didSelectItemsAt index:Set<IndexPath>) {
        text.string = messages[index.first!.item].0
    }
    
    func collectionView(_:NSCollectionView, didDeselectItemsAt index:Set<IndexPath>) {
        text.string = String()
    }
    
    func textView(_:NSTextView, doCommandBy selector:Selector) -> Bool {
        if (selector == #selector(NSResponder.insertNewline(_:))) {
            stopEditing()
            return true
        }
        return false
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        makeOutlets()
        presenter.updatedTitle = { [weak self] in self?.chapter.string = $0 }
        presenter.updatedMessages = { [weak self] in self?.messages = $0; self?.list.reloadData() }
        presenter.load()
    }
    
    private func makeOutlets() {
        let scrollChapter = NSScrollView(frame:.zero)
        scrollChapter.drawsBackground = false
        scrollChapter.translatesAutoresizingMaskIntoConstraints = false
        scrollChapter.hasHorizontalScroller = true
        addSubview(scrollChapter)
        
        let chapter = NSTextView(frame:.zero)
        chapter.drawsBackground = false
        chapter.textContainerInset = NSSize(width:10, height:20)
        chapter.isHorizontallyResizable = true
        chapter.isVerticallyResizable = true
        chapter.isContinuousSpellCheckingEnabled = true
        chapter.textContainer!.widthTracksTextView = true
        chapter.textContainer!.heightTracksTextView = true
        chapter.font = NSFont.systemFont(ofSize:14, weight:.light)
        chapter.delegate = self
        scrollChapter.documentView = chapter
        self.chapter = chapter
        
        let flow = NSCollectionViewGridLayout()
        flow.maximumNumberOfColumns = 1
        flow.minimumInteritemSpacing = 2
        flow.minimumLineSpacing = 2
        flow.margins = NSEdgeInsets(top:2, left:0, bottom:2, right:2)
        flow.minimumItemSize = NSSize(width:0, height:50)
        flow.maximumItemSize = NSSize(width:0, height:50)
        
        let scrollList = NSScrollView(frame:.zero)
        scrollList.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollList)
        
        let list = NSCollectionView(frame:.zero)
        list.collectionViewLayout = flow
        list.isSelectable = true
        list.delegate = self
        list.dataSource = self
        list.register(MessageCellView.self, forItemWithIdentifier:NSUserInterfaceItemIdentifier("cell"))
        scrollList.documentView = list
        self.list = list
        
        let scrollText = NSScrollView(frame:.zero)
        scrollText.translatesAutoresizingMaskIntoConstraints = false
        scrollText.hasVerticalScroller = true
        addSubview(scrollText)
        
        let text = NSTextView(frame:.zero)
        text.textContainerInset = NSSize(width:10, height:10)
        text.isVerticallyResizable = true
        text.isHorizontallyResizable = true
        text.isContinuousSpellCheckingEnabled = true
        text.textContainer!.widthTracksTextView = true
        text.textContainer!.heightTracksTextView = false
        text.font = NSFont.systemFont(ofSize:20, weight:.light)
        scrollText.documentView = text
        self.text = text
        
        scrollChapter.topAnchor.constraint(equalTo:topAnchor).isActive = true
        scrollChapter.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        scrollChapter.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
        scrollChapter.heightAnchor.constraint(equalToConstant:52).isActive = true
        
        scrollList.topAnchor.constraint(equalTo:chapter.bottomAnchor).isActive = true
        scrollList.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        scrollList.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        scrollList.widthAnchor.constraint(equalToConstant:200).isActive = true
        
        scrollText.topAnchor.constraint(equalTo:chapter.bottomAnchor).isActive = true
        scrollText.leftAnchor.constraint(equalTo:scrollList.rightAnchor, constant:2).isActive = true
        scrollText.rightAnchor.constraint(equalTo:rightAnchor, constant:-2).isActive = true
        scrollText.heightAnchor.constraint(equalToConstant:200).isActive = true
    }
    
    private func stopEditing() { DispatchQueue.main.async { [weak self] in self?.window?.makeFirstResponder(nil) } }
}
