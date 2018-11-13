import UIKit

class SplashView:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    /*
     override func didLoad() {
     DispatchQueue.global(qos:.background).async { [weak self] in self?.loadMaster() }
     }
     
     private func loadMaster() {
     let _ = Factory.makeMaster()
     DispatchQueue.main.asyncAfter(deadline:.now() + 2) { [weak self] in self?.closeSplash() }
     }
     
     private func closeSplash() {
     Application.navigation.setViewControllers([HomeView()], animated:true)
     }
 
 */
}
