import Foundation

public class Option:Decodable {
    public var text = String()
    public var next = String()
    public var effects = [Effect]()
    
    public init() { }
}
