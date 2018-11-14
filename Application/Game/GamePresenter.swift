import Foundation
import Hauptbahnhof

class GamePresenter {
    var text:((String) -> Void)?
    var options:(([(Int, String)]) -> Void)?
    private let master = Factory.makeMaster()
    
    func select(option:Int) {
        
    }
    
    func load() {
        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.next()
        }
    }
    
    @objc func home() { Application.navigation.setViewControllers([HomeView()], animated:true) }
    
    private func next() {
        let text = master.message.text
        let options = master.message.options.enumerated().map { ($0, $1.text) }
        DispatchQueue.main.async { [weak self] in
            self?.text?(text)
            self?.options?(options)
        }
    }
}
