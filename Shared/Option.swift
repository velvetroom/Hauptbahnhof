import Foundation

public struct Option:Decodable {
    public let text:String
    let next:String
    let effects:[Effect]
}
