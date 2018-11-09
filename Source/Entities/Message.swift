import Foundation

public class Message:Codable {
    public var text = String()
    public var options = [Option]()
    
    public init() { }
}
