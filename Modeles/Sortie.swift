import Foundation

struct Sortie: Codable {
    let nord: String?
    let sud: String?
    let est: String?
    let ouest: String?
}
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
