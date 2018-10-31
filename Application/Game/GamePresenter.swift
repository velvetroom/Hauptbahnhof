import CleanArchitecture

class GamePresenter:Presenter {
    @objc func home() {
        Application.navigation.setViewControllers([HomeView()], animated:true)
    }
}
