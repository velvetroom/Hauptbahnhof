import Foundation

public struct Game:Decodable {
    public let title:String
    let messages:[String:Message]
    private(set) var state:String
}
