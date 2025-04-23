import Foundation

struct Enigme: Codable {
    let id: Int
    let question: String
    let reponse: String
    let salleId: String
    var resolue: Bool
    var momentLimite: MomentDeLaJournee? // facultatif
    var tempsLimite: Int? // en secondes ⏱️
}
