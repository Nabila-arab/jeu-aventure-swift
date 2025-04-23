# 🧭 Jeu d'Aventure en Swift

Bienvenue dans un jeu d'aventure textuel en Swift ! Explore des salles mystérieuses, collecte des objets, résous des énigmes, et progresse dans un monde codé avec amour. 🧙‍♂️

---

## 🚀 Installation et Lancement

### 🧰 Prérequis

- **Visual Studio Code (https://code.visualstudio.com)**
- **[Docker Desktop](https://www.docker.com/products/docker-desktop/)**
- **[Swift](https://www.swift.org/download/) installé sur votre machine (`swiftc` ou `swift` en CLI).**
- **Un terminal et un éditeur de texte.**
- Git

### 🐳 Lancer avec Docker et Visual Studio Code (Dev Container)

Suivez ces étapes pour configurer et démarrer l'environnement de développement à l'aide de **VS Code Dev Containers**.


## 🗂️ Structure du projet
jeu-aventure-swift/ │ 
├── main.swift                          # Point d'entrée du jeu 
├── Data/ │
     ├── monde.json                     # Description du monde et des salles │ 
     ├── joueur_sauvegarde.json         # Sauvegarde du joueur │
     ├── joueur_init.json               # etat du joueur │

 ├── Modeles/ │
     ├── Enigme.swift │ 
     ├── Monde.swift │ 
     ├── Salle.swift │
     ├── Objet.swift │
     ├── Personnage.swift │ 
     ├── Sauvgarde.swift │  
     ├── Joueur.swift │ 
     ├── Sortie.swift │ 
 ├── Utilitaires/ │
     └── ChargerFichier.swift    # Méthodes de chargement de fichiers JSON │
└── README.md # Ce fichier




---

## ▶️ Lancer le jeu

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


Commande	          Description
aide ou ?	            Affiche les commandes disponibles
map	                    Affiche la carte du monde
objets	                Affiche les objets disponibles dans la salle
prendre	                Ramasse un objet dans la salle
sortir	                Affiche les directions possibles
pnj	                    Affiche les personnages présents dans la salle
enigme	                Tente de résoudre l'énigme de la salle
attendre ou dormir	    Fait passer le temps dans le jeu 
nord/sud/est/ouest	    Déplace ton joueur
quitter	                Sauvegarde la partie et quitte le jeu

🏁 Objectif
- Explorer toutes les salles 🗺️
- Résoudre toutes les énigmes 🧩
- Parler aux personnages 👤
- Collecter des objets utiles 🧰
- Survivre jusqu'à la fin du jeu 🎯
- Accumuler des points de score pour mesurer vos progrès 📈
