import Foundation

public protocol Storage {
    func loadPlayer() throws -> Player
    func loadGame(chapter:Chapter) -> Game
    func loadBoard() throws -> Board
    func save(player:Player)
    func save(game:Game)
    func save(board:Board)
    init()
}
