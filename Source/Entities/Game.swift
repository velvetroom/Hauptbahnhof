import Foundation

public struct Game:Codable {
    public internal(set) var chapter = Chapter.Unknown
    public internal(set) var messages = [String:Message]()
}
