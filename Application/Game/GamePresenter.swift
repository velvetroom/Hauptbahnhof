import CleanArchitecture
import MarkdownHero
import Hauptbahnhof

class GamePresenter:Presenter {
    private let hero = Hero()
    private let master = Factory.makeMaster()
    
    required init() {
        hero.font = .systemFont(ofSize:20, weight:.light)
    }
    
    @objc func home() {
        Application.navigation.setViewControllers([HomeView()], animated:true)
    }
    
    override func didLoad() {
        update(viewModel:master.game.title)
        update()
    }
    
    private func update() {
        update(viewModel:hero.parse(string:master.message.text))
    }
}
