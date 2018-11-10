import Cocoa

struct Status {
    static func loading() -> Status {
        var status = Status()
        status.image = NSImage(named:"loading")!
        status.image.isTemplate = true
        return status
    }
    
    static func failed(_ error:Error) -> Status {
        var status = Status()
        status.image = NSImage(named:"error")!
        status.image.isTemplate = true
        status.message = error.localizedDescription
        return status
    }
    
    static func success() -> Status {
        var status = Status()
        status.image = NSImage(named:"valid")!
        status.image.isTemplate = true
        return status
    }
    
    private(set) var image = NSImage()
    private(set) var message = String()
    private init() { }
}
