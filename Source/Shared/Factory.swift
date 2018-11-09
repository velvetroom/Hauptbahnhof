import Foundation

public class Factory {
    public static var storage:Storage.Type!
    private static var master:GameMaster!
    
    public class func makeMaster() -> GameMaster {
        if master == nil { master = GameMaster() }
        return master
    }
    
    class func makeStorage() -> Storage { return storage.init() }
    private init() { }
}
