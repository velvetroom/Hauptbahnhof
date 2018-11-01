import Foundation

public struct Game:Decodable {
    var state = String()
    public private(set) var title = String()
    private(set) var messages = [String:Message]()
}
