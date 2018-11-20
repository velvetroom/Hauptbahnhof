import UIKit
import Hauptbahnhof

class TitleView:UIViewController {
    private let master = Factory.makeMaster()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.isUserInteractionEnabled = false
        title.textAlignment = .center
        title.font = .systemFont(ofSize:25, weight:.bold)
        title.textColor = .white
        title.text = master.game.chapter.rawValue
        view.addSubview(title)
        
        title.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        moveIn()
    }
    
    private func moveIn() {
        UIView.animate(withDuration:0.3, animations: { [weak self] in
            self?.view.alpha = 1
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline:.now() + 2) { [weak self] in self?.moveOut() }
        }
    }
    
    private func moveOut() {
        UIView.animate(withDuration:1.5, animations: { [weak self] in
            self?.view.alpha = 0
        }) { _ in
            Application.navigation.setViewControllers([GameView()], animated:false)
        }
    }
}
