import CleanArchitecture
import MarkdownHero
import Hauptbahnhof

class GamePresenter:Presenter {
    var chapter = "One"
    private let hero = Hero()
    private let master = GameMaster()
    
    required init() {
        hero.font = .systemFont(ofSize:18, weight:.light)
    }
    
    @objc func home() {
        Application.navigation.setViewControllers([HomeView()], animated:true)
    }
    
    override func didLoad() {
        let chapter = self.chapter
        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.master.load(try! Data(contentsOf:Bundle.main.url(forResource:chapter, withExtension:"json")!))
            self?.update()
            if let title = self?.master.game.title { self?.update(viewModel:title) }
        }
    }
    
    private func update() {
        update(viewModel:hero.parse(string:master.message.text))
    }
}
