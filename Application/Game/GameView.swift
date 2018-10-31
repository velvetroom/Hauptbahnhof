import CleanArchitecture

class GameView:View<GamePresenter> {
    private weak var text:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeOutlets()
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
        text.textColor = .white
        text.indicatorStyle = .white
        text.font = .systemFont(ofSize:20, weight:.light)
        text.contentInset = .zero
        text.textContainerInset = UIEdgeInsets(top:10, left:15, bottom:20, right:15)
        text.text = "Hello world"
        text.isEditable = false
        view.addSubview(text)
        self.text = text
        
        bar.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        bar.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        text.topAnchor.constraint(equalTo:bar.bottomAnchor).isActive = true
        text.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        text.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        if #available(iOS 11.0, *) {
            text.contentInsetAdjustmentBehavior = .never
            bar.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            bar.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        }
    }
}
