import UIKit
import Hauptbahnhof

class SplashView:UIViewController {
    override func viewDidLoad() {
        let logo = UIImageView(image:#imageLiteral(resourceName: "splash.pdf"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.clipsToBounds = true
        logo.contentMode = .center
        logo.isUserInteractionEnabled = false
        view.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        logo.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated:Bool) {
        DispatchQueue.global(qos:.background).async {
            let _ = Factory.makeMaster()
            DispatchQueue.main.async {
                Application.navigation.setViewControllers([HomeView()], animated:true)
            }
        }
    }
}
