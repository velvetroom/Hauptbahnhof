import Foundation

class HomePresenter {
    @objc func newGame() {
        Application.navigation.setViewControllers([GameView()], animated:true)
    }
}
