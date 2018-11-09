import Foundation

public struct Game:Codable {
    public private(set) var chapter = Chapter.Unknown
    public var title = String()
    public var messages = [String:Message]()
    
    public init() { }
}
