import Foundation
import Hauptbahnhof

class HomePresenter {
    var viewModel:((HomeViewModel, (() -> Void)?) -> Void)!
    private let master = Factory.makeMaster()
    
    @objc func newGame() {
        viewModel(newGameOnly()) { [weak self] in self?.validateNewGame() }
    }
    
    private func validateNewGame() {
        if master.player.syncstamp > 0 {
            freshStart()
        } else {
            openGame()
        }
    }
    
    private func freshStart() {
        let alert = AlertView()
        alert.message = .local("HomePresenter.newGameMessage")
        alert.accept = .local("HomePresenter.newGameAccept")
        alert.cancel = .local("HomePresenter.newGameCancel")
        alert.onCancel = { [weak self] in self?.restore() }
        alert.onAccept = { [weak self] in self?.restart() }
        Application.navigation.pushViewController(alert, animated:false)
    }
    
    private func restore() {
        var viewModel = HomeViewModel()
        viewModel.enabled = true
        viewModel.newGameAlpha = 1
        self.viewModel(viewModel, nil)
    }
    
    private func restart() {
        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.master.restart()
            DispatchQueue.main.async { [weak self] in
                self?.openGame()
            }
        }
    }
    
    private func openGame() {
        Application.navigation.setViewControllers([TitleView()], animated:false)
    }
    
    private func newGameOnly() -> HomeViewModel {
        var viewModel = HomeViewModel()
        viewModel.newGameAlpha = 1
        return viewModel
    }
}
