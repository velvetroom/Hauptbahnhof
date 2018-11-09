import Foundation

public class Option:Codable {
    public var text = String()
    public var next = String()
    public var effects = [Effect]()
    
    public init() { }
}
