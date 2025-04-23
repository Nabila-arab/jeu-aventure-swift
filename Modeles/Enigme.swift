import Foundation

// Déclaration d'une structure représentant une énigme dans le jeu.
struct Enigme: Codable {
    let id: Int
    let question: String
    let reponse: String
    let salleId: String
    var resolue: Bool
    var momentLimite: MomentDeLaJournee? // optionel
    var tempsLimite: Int? // en secondes ⏱️
}
