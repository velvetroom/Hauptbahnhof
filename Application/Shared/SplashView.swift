import UIKit
import Hauptbahnhof

class SplashView:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        loadResources()
    }
    
    private func loadResources() {
        DispatchQueue.global(qos:.background).async {
            let _ = Factory.makeMaster()
            DispatchQueue.main.async {
                Application.navigation.setViewControllers([HomeView()], animated:true)
            }
        }
    }
}
