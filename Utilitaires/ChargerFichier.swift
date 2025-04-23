import Foundation

// Fonction pour charger et décoder un fichier JSON en un objet Swift.
func chargerFichier<T: Decodable>(_ chemin: String) -> T? {
    let url = URL(fileURLWithPath: chemin)
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let objet = try decoder.decode(T.self, from: data)
        return objet
    } catch {
        print("❌ Erreur de décodage des données du fichier : \(error)")
        return nil
    }
}
