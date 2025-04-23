import Foundation

// Structure représentant les personnages dans le jeu.
struct Personnage: Codable {
    let nom: String
    let description: String
    let salleId: String
    let dialogue: String?
    let momentApparition: MomentDeLaJournee?
}
