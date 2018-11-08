import Foundation

public struct Option:Decodable {
    public let text:String
    public let next:String
    public let effects:[Effect]
}
