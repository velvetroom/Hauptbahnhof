import Foundation
import Hauptbahnhof

class GamePresenter {
    private let master = Factory.makeMaster()
    
    func select(option:Int) {
        
    }
    
    @objc func home() {
        Application.navigation.setViewControllers([HomeView()], animated:true)
    }
    
    func didLoad() {
//        update(viewModel:master.game.title)
//        update()
    }
    
    private func update() {
//        update(viewModel:parser.parse(string:master.message.text))
//        update(viewModel:master.message.options.enumerated().map { ($0, $1.text) })
    }
}
