import Foundation

struct Personnage: Codable {
    let nom: String
    let description: String
    let salleId: String
    let dialogue: String?
    let momentApparition: MomentDeLaJournee?
}
