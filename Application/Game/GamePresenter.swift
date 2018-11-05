import CleanArchitecture
import MarkdownHero
import Hauptbahnhof

class GamePresenter:Presenter {
    private let parser = Hero()
    private let optionParser = Hero()
    private let master = Factory.makeMaster()
    
    func select(option:Int) {
        
    }
    
    required init() {
        parser.font = .systemFont(ofSize:20, weight:.light)
    }
    
    @objc func home() {
        Application.navigation.setViewControllers([HomeView()], animated:true)
    }
    
    override func didLoad() {
        update(viewModel:master.game.title)
        update()
    }
    
    private func update() {
        update(viewModel:parser.parse(string:master.message.text))
        update(viewModel:master.message.options.enumerated().map { ($0, $1.text) })
    }
}
