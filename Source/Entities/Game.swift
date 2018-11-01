import Foundation

public struct Game:Decodable {
    public private(set) var title = String()
    private(set) var messages = [String:Message]()
}
