import Foundation
import Dispatch
import Glibc
// Fonction pour forcer l'affichage dans le terminal (flush)
func flushOutput() {
    fflush(stdout)
}

// Chargement des données
let mondeOptionnel: Monde? = chargerFichier("Data/monde.json")
let joueurInit: Joueur? = chargerFichier("Data/joueur_init.json")
let sauvegardeOptionnel: Sauvegarde? = chargerFichier("Data/sauvegarde_jeu.json")
var joueur: Joueur?

guard var monde = mondeOptionnel, var joueur = joueurInit, var sauvegarde = sauvegardeOptionnel else {
    print("❌ Erreur lors du chargement des données du jeu.")
    exit(1)
}

print("\n✨--------------------------------------------✨")
print("👋 Bienvenue dans le jeu d'aventure !")

// Vérifier si le joueur existe ou pas dans la sauvegarde
print("🎮 Entrez votre nom : ", terminator: "")
if let nomJoueur = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
    chargerOuCreerJoueur(nom: nomJoueur, monde: monde)
}


print("""
✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
Bienvenue \(joueur.nom) dans l'aventure mystique de l'Ancienne Forteresse 🔮

Tu te réveilles dans une salle obscure, une torche vacille contre le mur...
Ton esprit est confus, mais une chose est claire : tu dois sortir vivant de ce labyrinthe mystérieux.

Explore les salles, collecte les objets, parle aux personnages, et résous les énigmes pour avancer.
Chaque choix peut t’approcher de la vérité… ou du danger.

Tape 'aide' ou '?' à tout moment pour voir les commandes disponibles.
Bonne chance, aventurier. 🍀
✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
""")

print("📍 Tu commences dans la première salle :")
print(joueur.salleActuelle.description)
//print(joueur.salleActuelle.description, "❌ Aucune salle actuelle")

var terminer = false
var momentActuel: MomentDeLaJournee = .matin

func avancerTemps() {
    if let index = MomentDeLaJournee.allCases.firstIndex(of: momentActuel) {
        let prochainIndex = (index + 1) % MomentDeLaJournee.allCases.count
        momentActuel = MomentDeLaJournee.allCases[prochainIndex]
        print("🕒 Le temps passe... Il est maintenant \(momentActuel.rawValue).")
    }
}

while !terminer {
    print("\n✨--------------------------------------------✨")
    print("\n➡️ Tape 'aide' ou '?' pour voir les commandes.")
    print("Que veux-tu faire ?")
    let commande = readLine()?.lowercased()

    switch commande {
    case "aide", "?": afficherAide()
    case "map": afficherCarte(monde: monde, joueur: joueur)
    case "prendre":
        print("Quel objet veux-tu prendre ?")
        if let objet = readLine() {
            ramasserObjet(objet: objet, joueur: &joueur, monde: &monde)
        }
    case "sortir": sortir(joueur: joueur, monde: monde)
    case "objets": afficherObjetsDansSalle(monde: monde, joueur: joueur)
    case "pnj": afficherPNJDansSalle(monde: monde, joueur: joueur)
    case "attendre", "dormir": avancerTemps()
    case "quitter":
        sauvegarderProgression(joueur: joueur)
        afficherScore(joueur: joueur)
        terminer = true
    case "enigme": resoudreEnigme(joueur: &joueur, monde: &monde)
    case "nord", "sud", "est", "ouest":
        if let direction = commande, let destinationId = joueur.salleActuelle.sorties[direction],
           let nouvelleSalle = monde.salles.first(where: { $0.id == destinationId }) {
            joueur.salleActuelle = nouvelleSalle
            print("🚪 Tu es maintenant dans la salle : \(nouvelleSalle.description)")
        } else {
            print("❌ Il n'y a pas de sortie dans cette direction.")
        }
    default:
        print("❌ Commande invalide. Tape 'aide' pour voir les commandes.")  
    }

}

// chargement/création du joueur
func chargerOuCreerJoueur(nom: String, monde: Monde) {
    let cheminSauvegarde = "Data/sauvegarde_jeu.json"
    let fileURL = URL(fileURLWithPath: cheminSauvegarde)

    var sauvegarde = Sauvegarde(joueurs: [])

    // 🔄 Charger la sauvegarde si elle existe
    if FileManager.default.fileExists(atPath: cheminSauvegarde),
       let data = try? Data(contentsOf: fileURL),
       let sauvegardesChargees = try? JSONDecoder().decode(Sauvegarde.self, from: data) {
        sauvegarde = sauvegardesChargees
    }

    // 🔍 Chercher le joueur existant
    if let joueurExistant = sauvegarde.joueurs.first(where: { $0.nom.lowercased() == nom.lowercased() }) {
        print("🔁 Bienvenue de retour, \(joueurExistant.nom) !")
        joueur = joueurExistant 
        
    }else{
        // Création nouveau joueur à partir de joueur init
        if joueurInit != nil {
            joueur = joueurInit! 
            joueur.nom = nom 
            print("✨ Nouveau joueur créé : \(nom)")
        }
    }
 
    print("\n✨--------------------------------------------✨\n")

}

func sauvegarderProgression(joueur: Joueur) {
    print("💾 Sauvegarde des données...")

     if let joueurExistant = sauvegarde.joueurs.first(where: { $0.nom.lowercased() == joueur.nom.lowercased() }) {
        print("🔁 Sauvegarde de lavancement de la partie de , \(joueurExistant.nom) !")
        // suppression de l'ancienne sauvegarde
        sauvegarde.joueurs.removeAll { $0.nom.lowercased() == joueur.nom.lowercased() }
    }

    // sauvegarde de la nouvelle version
    sauvegarde.joueurs.append(joueur)
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let sauvegardeJeu = try encoder.encode(sauvegarde)
        let url = URL(fileURLWithPath: "Data/sauvegarde_jeu.json")
        try sauvegardeJeu.write(to: url)
        print("✅ Progression sauvegardée.")
    } catch {
        print("❌ Erreur lors de la sauvegarde des données : \(error)")
    }
}

func afficherAide() {
    print("""
    Commandes disponibles :
    - 'aide' : Afficher cette aide
    - 'map' : Afficher la carte
    - 'objets' : Voir les objets dans la salle
    - 'prendre' : Prendre un objet
    - 'sortir' : Voir les sorties disponibles
    - 'enigme' : Tenter de résoudre l'énigme dans la salle
    - 'nord', 'sud', 'est', 'ouest' : Se déplacer
    - 'pnj' : Voir les personnages présents
    - 'attendre' ou 'dormir' : Faire passer le temps
    - 'quitter' : Quitter le jeu sans sauvegarder
    """)
}

func afficherCarte(monde: Monde, joueur: Joueur) {
    print("Carte du monde (Salle actuelle: \(joueur.salleActuelle.id)): ")
    for salle in monde.salles {
        print("\(salle.id): \(salle.description)")
    }
}

func afficherObjetsDansSalle(monde: Monde, joueur: Joueur) {
    if let salle = monde.salles.first(where: { $0.id == joueur.salleActuelle.id }),
       let objets = salle.objets {
        if objets.isEmpty {
            print("📦 Il n'y a aucun objet dans cette salle.")
        } else {
            print("📦 Objets disponibles dans cette salle :")
            for objet in objets {
                print("- \(objet.nom) : \(objet.description)")
            }
        }
    }
}

func ramasserObjet(objet: String, joueur: inout Joueur, monde: inout Monde) {
    if let salleIndex = monde.salles.firstIndex(where: { $0.id == joueur.salleActuelle.id }) {
        var objets = monde.salles[salleIndex].objets ?? []
        if let indexObjet = objets.firstIndex(where: { $0.nom.lowercased() == objet }) {
            let objetTrouve = objets.remove(at: indexObjet)
            
            // Eviter les doublans
            if !joueur.inventaire.contains(where: { $0.nom.lowercased() == objetTrouve.nom.lowercased() }) {
                joueur.inventaire.append(objetTrouve)
            }
            monde.salles[salleIndex].objets = objets
            print("✅ Tu as pris \(objetTrouve.nom).")
            // mise à jour du score
            joueur.score = joueur.score + 10 

        } else {
            print("❌ Cet objet n'est pas dans cette salle.")
        }
    }
}

func sortir(joueur: Joueur, monde: Monde) {
    let directions = ["nord", "sud", "est", "ouest"]
    for direction in directions {
        if let destination = joueur.salleActuelle.sorties[direction] {
            print("➡️ Tu peux aller vers \(direction) : \(String(describing: destination)).")
        } else {
            print("➡️ Il n'y a pas de sortie vers \(direction).")
        }
    }
}

func resoudreEnigme(joueur: inout Joueur, monde: inout Monde) {

    var joueurCopie = joueur
    var mondeCopie = monde

    guard let enigme = monde.enigmes.first(where: {
        $0.salleId == joueurCopie.salleActuelle.id &&
        !$0.resolue &&
        ($0.momentLimite == nil || momentActuel.rawValue <= $0.momentLimite!.rawValue)
    }) else {
        print("📭 Il n'y a aucune énigme à résoudre ici (ou le moment est dépassé).")
        return
    }

    print("❓ Énigme : \(enigme.question)\n")
    print("👉 Tu as 30 secondes. Ta réponse ? \n", terminator: "")
    fflush(stdout)

    var reponseDonnee: String? = nil
    let semaphore = DispatchSemaphore(value: 0)

    // Chrono parallèle
    DispatchQueue.global().async {
        for i in stride(from: 30, through: 1, by: -10) {  // décrémenter par 10
            sleep(10)  // pause de 10 seconde
            if semaphore.wait(timeout: .now()) == .success {
                return // On arrête si l'utilisateur a répondu
            }
            // Affiche le chrono sur une nouvelle ligne sans effacer (chaque 10 secondes)
            print("⏳ Il te reste \(i - 10)s")
        }

        print("\n⏳ Temps écoulé !")
        semaphore.signal()
    }

    // Lecture de la saisie du joueur
    if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
        reponseDonnee = input
        semaphore.signal() // Stop le chrono si réponse
    }

    // Si aucune réponse
    guard let reponse = reponseDonnee else {
        print("⌛️ Aucune réponse donnée.")
        return
    }

    // Vérification de la réponse
    if reponse.lowercased() == enigme.reponse.lowercased() {
        print("✅ Bonne réponse !")
        print("\n✨---------- Vous avez gagné 20 point ! ----------✨")
        // Mise à jour du score
        joueurCopie.score =  joueurCopie.score + 20
        joueurCopie.enigmesResolues.append(String(enigme.id))
        if let index = mondeCopie.enigmes.firstIndex(where: { $0.id == enigme.id }) {
            mondeCopie.enigmes[index].resolue = true
        }
    } else {
        print("❌ Mauvaise réponse. Réessaie plus tard.")
    }

    if joueurCopie.enigmesResolues.count == monde.enigmes.count {
        print("🏆 Toutes les énigmes ont été résolues ! Bravo !")
        afficherScore(joueur: joueurCopie)
        sauvegarderProgression(joueur: joueurCopie)
    }

    joueur = joueurCopie
    monde = mondeCopie
}

func afficherPNJDansSalle(monde: Monde, joueur: Joueur) {
    let pnjsDansSalle = monde.pnjs.filter {
        $0.salleId == joueur.salleActuelle.id &&
        ($0.momentApparition == nil || $0.momentApparition == momentActuel)
    }

    if pnjsDansSalle.isEmpty {
        print("👤 Il n'y a personne ici en ce moment (\(momentActuel.rawValue)).")
    } else {
        print("👥 Personnages présents (\(momentActuel.rawValue)) :")
        for pnj in pnjsDansSalle {
            print("- \(pnj.nom) : \(pnj.description)")
            if let dialogue = pnj.dialogue {
                print("  🗨️  \(dialogue)")
            }
        }
    }
}

func afficherScore(joueur: Joueur) {
    let pointsObjets = joueur.inventaire.count * 10
    let pointsEnigmes = joueur.enigmesResolues.count * 20
    let total = pointsObjets + pointsEnigmes

    print("🎉 Fin de l'aventure, \(joueur.nom) !")
    print("🧩 Énigmes résolues : \(joueur.enigmesResolues.count)")
    print("📦 Objets collectés : \(joueur.inventaire.count)")
    print("⭐️ Score final : \(total) points")
}