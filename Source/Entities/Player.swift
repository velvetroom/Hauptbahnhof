import Foundation

public class Player:Codable {
    public internal(set) var chapter = Chapter.Prologue
    public internal(set) var persona = Persona.Miranda
    public internal(set) var state = "initial"
    public internal(set) var syncstamp = 0.0
    public internal(set) var courage = 0
    public internal(set) var knowledge = 0
    public internal(set) var diligence = 0
    public internal(set) var empathty = 0
    public internal(set) var score = 0
}
