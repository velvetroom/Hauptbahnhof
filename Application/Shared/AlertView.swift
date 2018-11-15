import UIKit

class AlertView:UIViewController {
    var accept:(() -> Void)?
    var cancel:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        makeOutlets()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
    }
    
    private func makeOutlets() {
        
    }
}
