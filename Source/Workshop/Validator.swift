import Foundation

class Validator {
    private let validations:[((Validator) -> (Game) throws -> Void)] = [
        titleEmpty, messagesEmpty, idEmpty, noInitial, orphanMessage, textEmpty, textEndsNewLine, optionsEmpty,
        optionsLessThanTwo, optionEndsNewLine, nextInvalid, nextEmpty, nextRecursive, optionTextEmpty]
    
    func validate(_ game:Game) throws {
        try validations.forEach { try $0(self)(game) }
    }
    
    private func titleEmpty(_ game:Game) throws {
        if game.title.isEmpty { throw Invalid(.titleEmpty) }
    }
    
    private func messagesEmpty(_ game:Game) throws {
        if game.messages.isEmpty { throw Invalid(.messagesEmpty) }
    }
    
    private func idEmpty(_ game:Game) throws {
        try game.messages.keys.forEach { if $0.isEmpty { throw Invalid(.idEmpty) } }
    }
    
    private func noInitial(_ game:Game) throws {
        if game.messages["initial"] == nil { throw Invalid(.noInitial) }
    }
    
    private func orphanMessage(_ game:Game) throws {
        var messages = game.messages
        game.messages.values.forEach { message in
            message.options.forEach { option in
                messages.removeValue(forKey:option.next)
            }
        }
        if let first = messages.first(where: { $0.key != "initial" }) {
            throw Invalid(.orphanMessage, id:first.key)
        }
    }
    
    private func textEmpty(_ game:Game) throws {
        try game.messages.forEach { if $0.value.text.isEmpty { throw Invalid(.textEmpty, id:$0.key) } }
    }
    
    private func textEndsNewLine(_ game:Game) throws {
        try game.messages.forEach { if $0.value.text.last == "\n" { throw Invalid(.textEndsNewLine, id:$0.key) } }
    }
    
    private func optionsEmpty(_ game:Game) throws {
        try game.messages.forEach { id, message in
            if id != "final" && message.options.isEmpty {
                throw Invalid(.optionsEmpty, id:id)
            }
        }
    }
    
    private func optionsLessThanTwo(_ game:Game) throws {
        try game.messages.forEach { id, message in
            if id != "final" && message.options.count < 2 {
                throw Invalid(.optionsLessThanTwo, id:id)
            }
        }
    }
    
    private func optionEndsNewLine(_ game:Game) throws {
        try game.messages.forEach { id, message in
            try message.options.forEach { option in
                if option.text.last == "\n" { throw Invalid(.optionEndsNewLine, id:id) }
        } }
    }
    
    private func nextInvalid(_ game:Game) throws {
        try game.messages.forEach { id, message in
            try message.options.forEach { option in
                if game.messages[option.next] == nil { throw Invalid(.nextInvalid, id:id) }
        } }
    }
    
    private func nextEmpty(_ game:Game) throws {
        try game.messages.forEach { id, message in
            try message.options.forEach { option in
                if option.next.isEmpty { throw Invalid(.nextEmpty, id:id) }
        } }
    }
    
    private func nextRecursive(_ game:Game) throws {
        try game.messages.forEach { id, message in
            try message.options.forEach { option in
                if option.next == id { throw Invalid(.nextRecursive, id:id) }
        } }
    }
    
    private func optionTextEmpty(_ game:Game) throws {
        try game.messages.forEach { id, message in
            try message.options.forEach { option in
                if option.text.isEmpty { throw Invalid(.optionTextEmpty, id:id) }
        } }
    }
}
