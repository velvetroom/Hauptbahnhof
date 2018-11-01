import CleanArchitecture
import MarkdownHero

class GamePresenter:Presenter {
    private let hero = Hero()
    
    required init() {
        hero.font = .systemFont(ofSize:20, weight:.light)
    }
    
    @objc func home() {
        Application.navigation.setViewControllers([HomeView()], animated:true)
    }
    
    override func didAppear() {
        hero.parse(string:"Hello world") { [weak self] message in self?.update(viewModel:message) }
        
    }
}
