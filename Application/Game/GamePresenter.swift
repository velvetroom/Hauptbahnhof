import Foundation
import Hauptbahnhof

class GamePresenter {
    var message:((String) -> Void)?
    var options:(([(Int, String)]) -> Void)?
    private let master = Factory.makeMaster()
    
    func select(option:Int) {
        
    }
    
    func load() { next() }
    
    @objc func home() { Application.navigation.setViewControllers([HomeView()], animated:true) }
    
    private func next() {
        recursivePrint(text:String(), pile:master.message.text.components(separatedBy:"\n"))
    }
    
    private func recursivePrint(text:String, pile:[String]) {
        guard !pile.isEmpty else { return updateOptions() }
        var pile = pile
        let text = text + "\n" + pile.removeFirst()
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.4) { [weak self] in
            self?.message?(text)
            self?.recursivePrint(text:text, pile:pile)
        }
    }
    
    private func updateOptions() {
        options?(master.message.options.enumerated().map { ($0, $1.text) })
    }
}
