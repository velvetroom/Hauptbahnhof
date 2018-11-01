import Foundation

public struct Game:Decodable {
    public var title = String()
    var messages = [String:Message]()
    var state = String()
}
