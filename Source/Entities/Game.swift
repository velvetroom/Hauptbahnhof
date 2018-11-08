import Foundation

public struct Game:Decodable {
    public var title = String()
    public var messages = [String:Message]()
    
    public init() { }
}
