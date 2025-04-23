import Foundation

struct Joueur: Codable {
    var score: Int = 0
    var nom: String
    var inventaire: [Objet] = []  // par defaut à vide
    var enigmesResolues: [String] = []  // par defaut à vide
    var salleActuelle: Salle
}
