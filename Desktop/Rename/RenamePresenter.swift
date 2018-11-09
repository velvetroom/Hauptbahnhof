import Foundation
import Editor

class RenamePresenter {
    var id = String()
    
    @objc func cancel() {
        Application.window.endSheet(Application.window.attachedSheet!)
    }
}
