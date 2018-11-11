import Cocoa
import Editor

struct ViewModel {
    var title:((String) -> Void)!
    var status:((Status) -> Void)!
    var renaming:((Bool) -> Void)!
    var renameStatus:((Status) -> Void)!
    var messages:(([String:Message]) -> Void)!
    var item:((ItemView?) -> Void)!
    var shouldSelect:((String) -> Void)!
    weak var selected:ItemView? { willSet {
            selected?.selected = false
        } didSet {
            selected?.selected = true
            item(selected)
    } }
}
