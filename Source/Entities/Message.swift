import Foundation

public class Message:Decodable {
    public var text = String()
    public var options = [Option]()
    
    public init() { }
}
