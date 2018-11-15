import Foundation

class HomePresenter {
    var viewModel:((HomeViewModel, @escaping() -> Void) -> Void)!
    
    @objc func newGame() {
        var update = HomeViewModel()
        update.newGameAlpha = 1
        viewModel(update) {
            Application.navigation.setViewControllers([TitleView()], animated:false)
        }
    }
}
