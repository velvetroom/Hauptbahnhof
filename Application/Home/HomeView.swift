import UIKit

class HomeView:UIViewController {
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeOutlets()
    }
    
    private func makeOutlets() {
        let newGame = ButtonTextView(.local("HomeView.newGame"))
        newGame.addTarget(presenter, action:#selector(presenter.newGame), for:.touchUpInside)
        view.addSubview(newGame)
        
        newGame.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        newGame.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-100).isActive = true
    }
}
