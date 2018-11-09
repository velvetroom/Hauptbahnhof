import Foundation
import Editor

class RenamePresenter {
    weak var workshop:Workshop!
    var id = String()
    var viewModelStatus:((Status) -> Void)?
    var viewModelSaving:((Bool) -> Void)?
    
    @objc func cancel() {
        Application.window.endSheet(Application.window.attachedSheet!)
    }
    
    func save(name:String) {
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundRename(name:name) }
    }
    
    func validate(name:String) {
        updated(saving:false)
        updated(status:.loading())
        DispatchQueue.global(qos:.background).async { [weak self] in self?.backgroundValidate(name:name) }
    }
    
    private func backgroundValidate(name:String) {
        do {
            try workshop.validRename(id, to:name)
            updated(status:.success())
            updated(saving:true)
        } catch let error {
            updated(status:.failed(error:error))
            updated(saving:false)
        }
    }
    
    private func backgroundRename(name:String) {
        workshop.rename(id, to:name)
        DispatchQueue.main.async {
            Application.window.endSheet(Application.window.attachedSheet!)
        }
    }
    
    private func updated(saving:Bool) {
        DispatchQueue.main.async { [weak self] in self?.viewModelSaving?(saving) }
    }
    
    private func updated(status:Status) {
        DispatchQueue.main.async { [weak self] in self?.viewModelStatus?(status) }
    }
}
