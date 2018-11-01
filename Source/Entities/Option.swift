import Foundation

public struct Option:Decodable {
    public let text:String
    let effects:[Effect]
}
