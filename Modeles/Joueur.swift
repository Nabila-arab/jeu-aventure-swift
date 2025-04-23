import Foundation

// Déclaration de la structure représentant le joueur dans le jeu.
struct Joueur: Codable {
    var score: Int = 0
    var nom: String
    var inventaire: [Objet] = []  // par defaut il est vide au démarrage
    var enigmesResolues: [String] = []  // par defaut à vide
    var salleActuelle: Salle
}
