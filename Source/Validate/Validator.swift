import Foundation

public class Validator {
    private let validations:[((Validator) -> (Game) throws -> Void)] = [titleEmpty, messagesEmpty, textEmpty,
                                                                        optionsEmpty, optionsLessThanTwo, nextInvalid]
    
    public init() { }
    
    public func validate(_ game:Game) throws {
        try validations.forEach { try $0(self)(game) }
    }
    
    private func titleEmpty(_ game:Game) throws {
        if game.title.isEmpty { throw Invalid.titleEmpty }
    }
    
    private func messagesEmpty(_ game:Game) throws {
        if game.messages.isEmpty { throw Invalid.messagesEmpty }
    }
    
    private func textEmpty(_ game:Game) throws {
        try game.messages.values.forEach { if $0.text.isEmpty { throw Invalid.textEmpty } }
    }
    
    private func optionsEmpty(_ game:Game) throws {
        try game.messages.values.forEach { if $0.options.isEmpty { throw Invalid.optionsEmpty } }
    }
    
    private func optionsLessThanTwo(_ game:Game) throws {
        try game.messages.values.forEach { if $0.options.count < 2 { throw Invalid.optionsLessThanTwo } }
    }
    
    private func nextInvalid(_ game:Game) throws {
        try game.messages.values.forEach { try $0.options.forEach { option in
            if game.messages[option.next] == nil { throw Invalid.nextInvalid }
        } }
    }
}
