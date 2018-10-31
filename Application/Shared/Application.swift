import UIKit

@UIApplicationMain class Application:UIResponder, UIApplicationDelegate {
    static let navigation = Navigation()
    var window:UIWindow?
    
    func application(_:UIApplication, didFinishLaunchingWithOptions:[UIApplication.LaunchOptionsKey:Any]?) -> Bool {
        makeWindow()
        return true
    }
    
    private func makeWindow() {
        window = UIWindow(frame:UIScreen.main.bounds)
        window!.backgroundColor = .black
        window!.makeKeyAndVisible()
        window!.rootViewController = Application.navigation
    }
}
