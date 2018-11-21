import UIKit
import Hauptbahnhof

@UIApplicationMain class Application:UIResponder, UIApplicationDelegate {
    static let navigation = UINavigationController()
    var window:UIWindow?
    
    func application(_:UIApplication, didFinishLaunchingWithOptions:[UIApplication.LaunchOptionsKey:Any]?) -> Bool {
        injection()
        makeWindow()
        return true
    }
    
    private func injection() {
        Factory.storage = Session.self
    }
    
    private func makeWindow() {
        Application.navigation.setNavigationBarHidden(true, animated:false)
        Application.navigation.setViewControllers([SplashView()], animated:false)
        window = UIWindow(frame:UIScreen.main.bounds)
        window!.backgroundColor = .black
        window!.makeKeyAndVisible()
        window!.rootViewController = Application.navigation
    }
}
