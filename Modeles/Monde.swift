import Foundation


// Enum qui représente les différents moments de la journée (matin, après-midi, soir, nuit),
// utilisé pour rythmer l'aventure et limiter certaines actions selon le moment.
enum MomentDeLaJournee: String, Codable, CaseIterable {
    case matin
    case apresMidi
    case soir
    case nuit

    // Implémentation du protocole Comparable
    static func < (lhs: MomentDeLaJournee, rhs: MomentDeLaJournee) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}



// Struct représentant l'ensemble du monde de jeu.
// Il contient toutes les salles, objets, énigmes, personnages, et l'état du moment de la journée.
struct Monde: Codable {
    var salles: [Salle]
    var objets: [Objet]
    var enigmes: [Enigme]
    let pnjs: [Personnage]
    var moment: MomentDeLaJournee = .matin

    enum CodingKeys: String, CodingKey {
        case salles
        case objets
        case enigmes
        case pnjs
        case moment
    }
}


