import Foundation

struct Invalid:LocalizedError {
    enum Exception {
        case titleEmpty
        case messagesEmpty
        case textEmpty
        case optionsEmpty
        case optionsLessThanTwo
        case nextInvalid
        case optionTextEmpty
    }
    
    let localizedDescription:String
    
    init(_ type:Exception, id:String = String()) {
        localizedDescription = String(describing:type) + id
    }
}
