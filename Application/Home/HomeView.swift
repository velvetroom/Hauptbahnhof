import UIKit

class HomeView:UIViewController {
    private weak var newGame:ButtonTextView!
    private weak var newGameBottom:NSLayoutConstraint!
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        makeOutlets()
        presenter.viewModel = { [weak self] viewModel, completion in
            self?.newGame.isEnabled = false
            self?.newGame.alpha = viewModel.newGameAlpha
            UIView.animate(withDuration:1, animations: { [weak self] in
                self?.view.alpha = 0
            }) { _ in completion() }
        }
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration:2, animations: { [weak self] in
            self?.view.alpha = 1
        }) { [weak self] _ in
            self?.newGameBottom.constant = -100
            UIView.animate(withDuration:1) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    private func makeOutlets() {
        let sky = HomeSkyView()
        view.addSubview(sky)
        
        let newGame = ButtonTextView(.local("HomeView.newGame"))
        newGame.addTarget(presenter, action:#selector(presenter.newGame), for:.touchUpInside)
        view.addSubview(newGame)
        self.newGame = newGame
        
        sky.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        sky.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        sky.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        sky.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        newGame.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        newGameBottom = newGame.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:40)
        newGameBottom.isActive = true
    }
}
