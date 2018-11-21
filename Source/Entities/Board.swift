import Foundation

public struct Board:Codable {
    public var purchases = [Purchase]()
    var rates = [Date]()
    var continues = 0
}
