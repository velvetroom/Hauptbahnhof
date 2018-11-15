import UIKit

class GameView:UIViewController{
    private weak var caret:GameCaretView!
    private weak var text:UITextView!
    private weak var menu:UIView!
    private weak var menuLeft:NSLayoutConstraint!
    private let presenter = GamePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeOutlets()
        presenter.message = { [weak self] in self?.update(message:$0) }
        presenter.options = { [weak self] in self?.update(options:$0) }
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        presenter.next()
    }
    
    private func makeOutlets() {
        let home = ButtonView(#imageLiteral(resourceName: "home.pdf"))
        home.addTarget(self, action:#selector(self.home), for:.touchUpInside)
        view.addSubview(home)
        
        let profile = ButtonView(#imageLiteral(resourceName: "profile.pdf"))
        profile.addTarget(self, action:#selector(self.profile), for:.touchUpInside)
        view.addSubview(profile)
        
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.indicatorStyle = .white
        text.textColor = .white
        text.font = .systemFont(ofSize:18, weight:.light)
        text.textContainerInset = UIEdgeInsets(top:10, left:15, bottom:20, right:15)
        text.isEditable = false
        view.addSubview(text)
        self.text = text
        
        let caret = GameCaretView()
        text.addSubview(caret)
        self.caret = caret
        
        let menu = UIView()
        menu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menu)
        self.menu = menu
        
        caret.top = caret.topAnchor.constraint(equalTo:text.topAnchor)
        caret.left = caret.leftAnchor.constraint(equalTo:text.leftAnchor)
        caret.height = caret.heightAnchor.constraint(equalToConstant:0)
        
        home.rightAnchor.constraint(equalTo:view.centerXAnchor, constant:-15).isActive = true
        
        profile.bottomAnchor.constraint(equalTo:home.bottomAnchor).isActive = true
        profile.leftAnchor.constraint(equalTo:view.centerXAnchor, constant:15).isActive = true
        
        text.bottomAnchor.constraint(equalTo:menu.topAnchor).isActive = true
        text.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        menu.widthAnchor.constraint(equalToConstant:UIScreen.main.bounds.width).isActive = true
        menu.bottomAnchor.constraint(equalTo:home.topAnchor, constant:-10).isActive = true
        menuLeft = menu.leftAnchor.constraint(equalTo:view.leftAnchor, constant:UIScreen.main.bounds.width)
        menuLeft.isActive = true
        
        if #available(iOS 11.0, *) {
            home.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-15).isActive = true
            text.contentInsetAdjustmentBehavior = .never
            text.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            home.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-15).isActive = true
            text.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        }
    }
    
    private func update(message:String) {
        text.text = message
        DispatchQueue.main.async { [weak self] in self?.updateCaret() }
    }
    
    private func updateCaret() {
        caret.update(rect:text.caretRect(for:text.endOfDocument))
        text.scrollRangeToVisible(NSMakeRange(text.text.count - 1, 1))
    }
    
    private func update(options:[(Int, String)]) {
        menu.subviews.forEach { $0.removeFromSuperview() }
        var top = menu.topAnchor
        options.forEach { option in
            let view = GameOptionView()
            view.viewModel = option
            view.addTarget(self, action:#selector(select(option:)), for:.touchUpInside)
            menu.addSubview(view)
            
            view.topAnchor.constraint(equalTo:top, constant:5).isActive = true
            view.leftAnchor.constraint(equalTo:menu.leftAnchor, constant:5).isActive = true
            view.rightAnchor.constraint(equalTo:menu.rightAnchor, constant:20).isActive = true
            top = view.bottomAnchor
        }
        menu.bottomAnchor.constraint(equalTo:top, constant:5).isActive = true
        view.isUserInteractionEnabled = true
        UIView.animate(withDuration:0.6, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }) { [weak self] _ in
            self?.menuLeft.constant = 0
            UIView.animate(withDuration:0.4) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    private func animateOut() {
        menuLeft.constant = UIScreen.main.bounds.width
        UIView.animate(withDuration:0.3, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration:0.5, animations: { [weak self] in
                self?.text.alpha = 0
            }) { [weak self] _ in
                self?.update(message:String())
                UIView.animate(withDuration:0.4, animations: { [weak self] in
                    self?.text.alpha = 1
                }) { _ in
                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) { [weak self] in
                        self?.text.alpha = 1
                        self?.presenter.next()
                    }
                }
            }
        }
    }
    
    private func fadeOut(completion:@escaping(() -> Void)) {
        UIView.animate(withDuration:0.6, animations: { [weak self] in
            self?.view.alpha = 0
        }) { _ in
            completion()
        }
    }
    
    @objc private func select(option:GameOptionView) {
        view.isUserInteractionEnabled = false
        option.isSelected = true
        presenter.select(option:option.viewModel!.0)
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.3) { [weak self] in
            self?.animateOut()
        }
    }
    
    @objc private func home() {
        view.isUserInteractionEnabled = false
        fadeOut {
            Application.navigation.setViewControllers([HomeView()], animated:true)
        }
    }
    
    @objc private func profile() {
        view.isUserInteractionEnabled = false
        fadeOut {
            Application.navigation.setViewControllers([ProfileView()], animated:true)
        }
    }
}
