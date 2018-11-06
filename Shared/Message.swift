import Foundation

public struct Message:Decodable {
    public let text:String
    public let options:[Option]
}
