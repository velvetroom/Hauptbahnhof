import Foundation
import Hauptbahnhof

class GamePresenter {
    var message:((String) -> Void)?
    var options:(([(Int, String)]) -> Void)?
    var chapterEnd:(() -> Void)?
    private let master = Factory.makeMaster()
    
    func next() {
        recursivePrint(text:String(), pile:master.message.text)
    }
    
    func select(option:Int) {
        master.select(master.message.options[option])
    }
    
    @objc func tryContinue() {
        let alert = AlertView()
        alert.message = .local("GamePresenter.tryContinueMessage")
        alert.accept = .local("GamePresenter.tryContinueAccept")
        Application.navigation.pushViewController(alert, animated:false)
    }
    
    private func recursivePrint(text:String, pile:String) {
        guard !pile.isEmpty else { return updateOptions() }
        var pile = pile
        let text = text + String(pile.removeFirst())
        DispatchQueue.main.asyncAfter(deadline:.now() + 0.01) { [weak self] in
            self?.message?(text)
            self?.recursivePrint(text:text, pile:pile)
        }
    }
    
    private func updateOptions() {
        if master.player.state == "final" {
            chapterEnd?()
        } else {
            options?(master.message.options.enumerated().map { ($0, $1.text) })
        }
    }
}
