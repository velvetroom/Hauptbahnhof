import Foundation

public protocol Storage {
    func loadPlayer() throws -> Player
    func loadGame(chapter:Chapter) -> Game
    func save(player:Player)
    func save(game:Game)
    init()
}
