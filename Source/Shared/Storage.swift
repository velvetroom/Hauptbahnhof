import Foundation

public protocol Storage {
    func loadPlayer() throws -> Player
    func loadGame(chapter:String) -> Game
    func save(player:Player)
    init()
}
