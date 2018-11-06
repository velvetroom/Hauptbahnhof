import Foundation
import Editor

class HomePresenter {
    var update:((Home) -> Void)?
    var game = Game()
    
    func load() {
        let data = try! Data(contentsOf:Bundle.main.url(forResource:"One", withExtension:"json")!)
        game = try! JSONDecoder().decode(Game.self, from:data)
        updateViewModel()
    }
    
    private func updateViewModel() {
        var viewModel = Home()
        viewModel.name = game.title
        viewModel.items = game.messages.map { id, message in
            var item = HomeItem()
            item.id = id
            item.options = message.options.count
            return item
        }
        update?(viewModel)
    }
}
