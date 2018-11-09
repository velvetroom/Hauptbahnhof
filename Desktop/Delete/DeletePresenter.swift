import Foundation

class DeletePresenter {
    var id = String()
    
    @objc func cancel() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.cancel)
    }
    
    @objc func delete() {
        Application.window.endSheet(Application.window.attachedSheet!, returnCode:.continue)
    }
}
