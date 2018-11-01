import Foundation

public protocol Storage {
    func load() throws -> Player
    func save(player:Player)
    init()
}
