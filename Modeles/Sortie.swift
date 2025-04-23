import Foundation

// Structure représentant les sorties d'une salle dans le jeu.
// Chaque direction (nord, sud, est, ouest) peut pointer vers l'identifiant d'une autre salle.
struct Sortie: Codable {
    let nord: String?
    let sud: String?
    let est: String?
    let ouest: String?
}
// Extension ajoutant une souscription par direction (ex: sorties["nord"])
// Permet un accès plus pratique aux directions avec une simple chaîne.
extension Sortie {
    subscript(direction: String) -> String? {
        switch direction {
        case "nord": return nord
        case "sud": return sud
        case "est": return est
        case "ouest": return ouest
        default: return nil
        }
    }
}
