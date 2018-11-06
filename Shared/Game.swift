import Foundation

public struct Game:Decodable {
    public private(set) var title = String()
    public private(set) var messages = [String:Message]()
    
    public init() { }
}
