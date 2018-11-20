import Foundation

class Validator {
    private let validations:[((Validator) -> (Game) throws -> Void)] = [
        titleEmpty, messagesEmpty, idEmpty, noInitial, orphanMessage, messageNotOnline, textEmpty, textEndsNewLine,
        optionsEmpty, optionsLessThanTwo, optionEndsNewLine, nextInvalid, nextEmpty, nextRecursive, optionTextEmpty,
        nextInitial, finalWithOptions, graphToFinal]
    
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
    
    private func messageNotOnline(_ game:Game) throws {
        var messages = game.messages
        var pile = ["initial"]
        var counter = 0
        while counter < pile.count {
            if let message = game.messages[pile[counter]] {
                message.options.forEach { option in
                    if !pile.contains(option.next) {
                        pile.append(option.next)
                        messages.removeValue(forKey:option.next)
                    }
                }
            }
            counter += 1
        }
        if let first = messages.first(where: { $0.key != "initial" }) {
            throw Invalid(.messageNotOnLine, id:first.key)
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
    
    private func nextInitial(_ game:Game) throws {
        try game.messages.forEach { id, message in
            try message.options.forEach { option in
                if option.next == "initial" { throw Invalid(.nextInitial, id:id) }
        } }
    }
    
    private func finalWithOptions(_ game:Game) throws {
        if let message = game.messages["final"] {
            if !message.options.isEmpty {
                throw Invalid(.finalWithOptions)
            }
        }
    }
    
    private func graphToFinal(_ game:Game) throws {
        var map = [String:Bool]()
        recursiveGraph(check:"initial", game:game, map:&map)
        try map.forEach { id, completed in
            if !completed {
                throw Invalid(.graphToFinal, id:id)
            }
        }
    }
    
    private func recursiveGraph(check:String, game:Game, map:inout[String:Bool]) {
        if check == "final" {
            map["final"] = true
        } else if let message = game.messages[check] {
            message.options.forEach { option in
                if let finished = map[option.next] {
                    if finished {
                        map[check] = true
                    }
                } else {
                    map[option.next] = false
                    recursiveGraph(check:option.next, game:game, map:&map)
                    if map[option.next] == true {
                        map[check] = true
                    }
                }
            }
        }
    }
}
