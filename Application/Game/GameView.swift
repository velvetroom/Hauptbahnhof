import CleanArchitecture

class GameView:View<GamePresenter> {
    private weak var bar:Bar!
    private weak var text:UITextView!
    private weak var caret:GameCaretView!
    
    override func viewDidLoad() {
        makeOutlets()
        viewModel()
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    private func makeOutlets() {
        let home = Button(#imageLiteral(resourceName: "home.pdf"))
        home.addTarget(presenter, action:#selector(presenter.home), for:.touchUpInside)
        
        let profile = Button(#imageLiteral(resourceName: "profile.pdf"))
        
        let bar = Bar([profile, home])
        view.addSubview(bar)
        self.bar = bar
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.indicatorStyle = .white
        text.textContainerInset = UIEdgeInsets(top:10, left:15, bottom:20, right:15)
        text.isEditable = false
        view.addSubview(text)
        self.text = text
        
        let caret = GameCaretView()
        view.addSubview(caret)
        self.caret = caret
        
        bar.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        bar.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        text.topAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        text.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        caret.top = caret.topAnchor.constraint(equalTo:text.topAnchor)
        caret.left = caret.leftAnchor.constraint(equalTo:text.leftAnchor)
        caret.height = caret.heightAnchor.constraint(equalToConstant:0)
        
        text.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        if #available(iOS 11.0, *) {
            text.contentInsetAdjustmentBehavior = .never
            bar.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            bar.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        }
    }
    
    private func viewModel() {
        presenter.viewModel { [weak self] (title:String) in self?.bar.label.text = title }
        presenter.viewModel { [weak self] (message:NSAttributedString) in self?.update(message:message) }
    }
    
    private func update(message:NSAttributedString) {
        text.attributedText = message
        text.textColor = .white
        caret.update(rect:text.caretRect(for:text.endOfDocument))
    }
}
