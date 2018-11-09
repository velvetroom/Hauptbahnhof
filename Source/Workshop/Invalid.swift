import Foundation

struct Invalid:LocalizedError {
    enum Exception {
        case titleEmpty
        case messagesEmpty
        case idEmpty
        case textEmpty
        case optionsEmpty
        case optionsLessThanTwo
        case nextInvalid
        case optionTextEmpty
    }
    
    var errorDescription:String?
    
    init(_ type:Exception, id:String = String()) {
        errorDescription = String(describing:type) + id
    }
}
