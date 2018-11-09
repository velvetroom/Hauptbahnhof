import Foundation

public struct Game:Decodable {
    var chapter = Chapter.Unknown
    public var title = String()
    public var messages = [String:Message]()
    
    public init() { }
}
