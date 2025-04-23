import Foundation

// Codable indique que cette struct peut être encodée/décodée en JSON
struct Salle: Codable {
    let id: String
    let description: String
    //  liste optionnelle d'objets (Objet) présents dans la salle. Peut être vide ou absente.
    var objets: [Objet]?
    let sorties: [String: String?]

   // déclarer quelles clés JSON correspondent à quelles propriétés
    enum CodingKeys: String, CodingKey {
        case id, description, objets, sorties
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        sorties = try container.decode([String: String?].self, forKey: .sorties)
        objets = try container.decodeIfPresent([Objet].self, forKey: .objets) ?? []
    }
}
