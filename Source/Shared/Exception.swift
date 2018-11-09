import Foundation

public struct Exception:LocalizedError {
    public static let unknown = Exception()
    public static let emptyName = Exception("Empty name not allowed")
    public static let nameExists = Exception("Name already exists")
    
    public var errorDescription:String?
    
    init(_ errorDescription:String = String()) {
        self.errorDescription = errorDescription
    }
}
