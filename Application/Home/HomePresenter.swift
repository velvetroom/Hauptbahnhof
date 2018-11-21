import Foundation
import Hauptbahnhof
import StoreKit

class HomePresenter {
    var viewModel:((HomeViewModel) -> Void)! { didSet { restore() } }
    var fadeOut:((@escaping() -> Void) -> Void)!
    private let master = Factory.makeMaster()
    
    @objc func new() {
        viewModel(newOnly())
        fadeOut { [weak self] in self?.validateNewGame() }
    }
    
    @objc func resume() {
        viewModel(resumeOnly())
        fadeOut { [weak self] in self?.openGame() }
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
        viewModel.newEnabled = true
        viewModel.newAlpha = 1
        if master.player.syncstamp > 0 {
            viewModel.resumeEnabled = true
            viewModel.resumeAlpha = 1
        }
        self.viewModel(viewModel)
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
        if master.rate() { if #available(iOS 10.3, *) { SKStoreReviewController.requestReview() } }
        Application.navigation.setViewControllers([TitleView()], animated:false)
    }
    
    private func newOnly() -> HomeViewModel {
        var viewModel = HomeViewModel()
        viewModel.newAlpha = 1
        return viewModel
    }
    
    private func resumeOnly() -> HomeViewModel {
        var viewModel = HomeViewModel()
        viewModel.resumeAlpha = 1
        return viewModel
    }
}
