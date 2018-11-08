import Foundation

enum Invalid:Error {
    case titleEmpty
    case messagesEmpty
    case textEmpty
    case optionsEmpty
    case optionsLessThanTwo
    case nextInvalid
}
