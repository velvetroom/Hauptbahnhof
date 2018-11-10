import Foundation

public class Option:Codable {
    public internal(set) var text = String()
    public internal(set) var next = String()
    public internal(set) var effects = [Effect]()
}
