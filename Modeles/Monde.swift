import Foundation


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


