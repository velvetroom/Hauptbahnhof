import Foundation

struct Invalid:LocalizedError {
    enum Exception {
        case titleEmpty
        case messagesEmpty
        case idEmpty
        case noInitial
        case orphanMessage
        case textEmpty
        case textEndsNewLine
        case optionsEmpty
        case optionsLessThanTwo
        case optionEndsNewLine
        case nextInvalid
        case nextEmpty
        case nextRecursive
        case optionTextEmpty
    }
    
    var errorDescription:String?
    
    init(_ type:Exception, id:String = String()) {
        errorDescription = String(describing:type) + ":" + id
    }
}
