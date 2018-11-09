import Foundation

public struct Game:Codable {
    public private(set) var chapter = Chapter.Unknown
    public internal(set) var title = String()
    public internal(set) var messages = [String:Message]()
}
