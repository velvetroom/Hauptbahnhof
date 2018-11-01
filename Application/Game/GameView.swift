import CleanArchitecture

class GameView:View<GamePresenter> {
    private weak var text:UITextView!
    private weak var caret:UIView!
    private weak var caretLeft:NSLayoutConstraint!
    private weak var caretTop:NSLayoutConstraint!
    private weak var caretHeight:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeOutlets()
        viewModel()
    }
    
    private func makeOutlets() {
        let home = Button(#imageLiteral(resourceName: "home.pdf"))
        home.addTarget(presenter, action:#selector(presenter.home), for:.touchUpInside)
        
        let profile = Button(#imageLiteral(resourceName: "profile.pdf"))
        
        let bar = Bar("Chapter One", buttons:[profile, home])
        view.addSubview(bar)
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.indicatorStyle = .white
        text.textContainerInset = UIEdgeInsets(top:10, left:15, bottom:20, right:15)
        text.isEditable = false
        view.addSubview(text)
        self.text = text
        
        let caret = UIView()
        caret.translatesAutoresizingMaskIntoConstraints = false
        caret.isUserInteractionEnabled = false
        caret.backgroundColor = .spreeBlue
        view.addSubview(caret)
        self.caret = caret
        
        bar.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        bar.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        text.topAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        text.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        caretTop = caret.topAnchor.constraint(equalTo:text.topAnchor)
        caretLeft = caret.leftAnchor.constraint(equalTo:text.leftAnchor)
        caretHeight = caret.heightAnchor.constraint(equalToConstant:0)
        caret.widthAnchor.constraint(equalToConstant:8).isActive = true
        caretTop.isActive = true
        caretLeft.isActive = true
        caretHeight.isActive = true
        
        text.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        if #available(iOS 11.0, *) {
            text.contentInsetAdjustmentBehavior = .never
            bar.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            bar.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        }
    }
    
    private func viewModel() {
        presenter.viewModel { [weak self] (message:NSAttributedString) in self?.update(message:message) }
    }
    
    private func update(message:NSAttributedString) {
        text.attributedText = message
        text.textColor = .white
        let rect = text.caretRect(for:text.endOfDocument)
        caretTop.constant = rect.minY
        caretLeft.constant = rect.minX + 5
        caretHeight.constant = rect.height
    }
}
