import CleanArchitecture

class GameView:View<GamePresenter> {
    private weak var bar:Bar!
    private weak var caret:GameCaretView!
    private weak var text:UITextView!
    private weak var menu:UIView!
    
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
        
        let caret = GameCaretView()
        view.addSubview(caret)
        self.caret = caret
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.indicatorStyle = .white
        text.textContainerInset = UIEdgeInsets(top:10, left:15, bottom:20, right:15)
        text.isEditable = false
        view.addSubview(text)
        self.text = text
        
        let menu = UIView()
        menu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menu)
        self.menu = menu
        
        bar.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        bar.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        caret.top = caret.topAnchor.constraint(equalTo:text.topAnchor)
        caret.left = caret.leftAnchor.constraint(equalTo:text.leftAnchor)
        caret.height = caret.heightAnchor.constraint(equalToConstant:0)
        
        text.topAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        text.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        menu.topAnchor.constraint(equalTo:text.bottomAnchor).isActive = true
        menu.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        menu.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            text.contentInsetAdjustmentBehavior = .never
            bar.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            menu.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            bar.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            menu.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        }
    }
    
    private func viewModel() {
        presenter.viewModel { [weak self] (title:String) in self?.bar.label.text = title }
        presenter.viewModel { [weak self] (message:NSAttributedString) in self?.update(message:message) }
        presenter.viewModel { [weak self] (options:[NSAttributedString]) in self?.update(options:options) }
    }
    
    private func update(message:NSAttributedString) {
        text.attributedText = message
        text.textColor = .white
        caret.update(rect:text.caretRect(for:text.endOfDocument))
    }
    
    private func update(options:[NSAttributedString]) {
        var top = menu.topAnchor
        options.forEach { option in
            let view = GameOptionView()
            view.viewModel = option
            menu.addSubview(view)
            
            view.topAnchor.constraint(equalTo:top, constant:20).isActive = true
            view.leftAnchor.constraint(equalTo:menu.leftAnchor, constant:20).isActive = true
            view.rightAnchor.constraint(equalTo:menu.rightAnchor, constant:20).isActive = true
            top = view.bottomAnchor
        }
    }
}
