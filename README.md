# 🧭 Jeu d'Aventure en Swift

Bienvenue dans un jeu d'aventure textuel en Swift ! Explore des salles mystérieuses, collecte des objets, résous des énigmes, et progresse dans un monde codé avec amour. 🧙‍♂️

---

## 🗂️ Structure du projet
jeu-aventure-swift/ │ 
├── main.swift # Point d'entrée du jeu 
├── Data/ │
     ├── monde.json # Description du monde et des salles │ 
     ├── joueur_sauvegarde.json # Sauvegarde du joueur │
 ├── Modeles/ │
     ├── Monde.swift │ 
     ├── Salle.swift │
     ├── Objet.swift │ 
     ├── Joueur.swift │ 
 ├── Utilitaires/ │
     └── ChargerFichier.swift # Méthodes de chargement de fichiers JSON │
└── README.md # Ce fichier




---

## ▶️ Lancer le jeu

### ✅ Prérequis

- [Swift](https://www.swift.org/download/) installé sur votre machine (`swiftc` ou `swift` en CLI).
- Un terminal et un éditeur de texte.

### 🚀 Compilation

Dans le dossier racine du projet, exécute :

```bash
swiftc -o jeu main.swift Modeles/*.swift Utilitaires/*.swift

Cela va générer un exécutable nommé jeu.

🕹️ Exécution
Ensuite, lance le jeu avec :
./jeu



Commandes disponibles
Une fois dans le jeu, tu peux taper les commandes suivantes :


Commande	Description
aide	            Affiche les commandes disponibles
map	                Affiche la carte du monde
objets	            Affiche les objets disponibles dans la salle
prendre	            Ramasse un objet dans la salle
sortir	            Affiche les directions possibles
nord/sud/est/ouest	Déplace ton joueur
quitter	            Sauvegarde la partie et quitte le jeu