import Foundation

public class Message:Codable {
    public internal(set) var text = String()
    public internal(set) var options = [Option]()
}
