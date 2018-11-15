import Foundation

struct Invalid:LocalizedError {
    enum Exception {
        case titleEmpty
        case messagesEmpty
        case idEmpty
        case noInitial
        case textEmpty
        case textEndsNewLine
        case optionsEmpty
        case optionsLessThanTwo
        case optionEndsNewLine
        case nextInvalid
        case optionTextEmpty
    }
    
    var errorDescription:String?
    
    init(_ type:Exception, id:String = String()) {
        errorDescription = String(describing:type) + ":" + id
    }
}
