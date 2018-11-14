import UIKit

class HomeView:UIViewController {
    private let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeOutlets()
    }
    
    private func makeOutlets() {
        let sky = HomeSkyView()
        view.addSubview(sky)
        
        let newGame = ButtonTextView(.local("HomeView.newGame"))
        newGame.addTarget(presenter, action:#selector(presenter.newGame), for:.touchUpInside)
        view.addSubview(newGame)
        
        sky.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        sky.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        sky.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        sky.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        newGame.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        newGame.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-100).isActive = true
    }
}
