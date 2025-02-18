### Objectif: ajouter un backend à notre application mobile
Ajouter un backend pour stocker les utilisateurs et les scores dans notre application mobile de jeux avec l'API des pays.

### Fonctionnalités
1. **Gestion des utilisateurs** :
   - **Enregistrement et authentification** : permettre aux utilisateurs de créer un compte et de se connecter.
   - **Suivi des profils d'utilisateurs** : affichage et mise à jour des informations personnelles comme l'avatar, l'email, et les statistiques de jeu.

2. **Stockage des scores** :
   - **Enregistrement des scores** : après chaque partie, les scores sont sauvegardés dans la base de données.
   - **Classements** : affichage des classements globaux.
   - **Historique des performances** : permettre aux utilisateurs de visualiser leurs performances passées.

### Stack recommandée pour le backend
- **Framework** : Express.js (Node.js) pour gérer les utilisateurs et les scores.
- **Base de données** : MySQL pour stocker les informations des utilisateurs et des scores.
- **API RESTful** : Mise en place d’une API RESTful pour la communication entre l’application mobile et le backend, avec des endpoints pour l’authentification, le stockage et la récupération des scores.

### Pages à ajouter dans l'application mobile

1. **Page d'inscription et de connexion** :
   - **Fonctionnalité** : L'utilisateur peut créer un compte ou se connecter.
   - **Interaction backend** : Appel à l'API pour enregistrer un nouvel utilisateur ou pour authentifier un utilisateur existant.
   - **EndPoint API** : 
     - `POST /register` (inscription)
     - `POST /login` (connexion)

2. **Page de profil utilisateur** :
   - **Fonctionnalité** : L'utilisateur peut consulter et modifier son profil (photo de profil, nom d'utilisateur, email).
   - **Interaction backend** : Récupérer et mettre à jour les informations de l'utilisateur.
   - **EndPoint API** : 
     - `GET /profile` (récupérer le profil)
     - `PUT /profile` (mettre à jour le profil)

3. **Page de jeu** :
   - **Fonctionnalité** : Interface de jeu avec l'API des pays. À la fin de la partie, le score est enregistré dans la base de données.
   - **Interaction backend** : Enregistrer le score dans la base de données après chaque partie.
   - **EndPoint API** :
     - `POST /score` (envoyer le score après la partie)

4. **Page des classements** :
   - **Fonctionnalité** : Afficher les classements globaux.
   - **Interaction backend** : Récupérer les meilleurs scores des utilisateurs pour générer un classement.
   - **EndPoint API** :
     - `GET /leaderboard` (récupérer les classements globaux)

5. **Page d'historique des scores** :
   - **Fonctionnalité** : Afficher l'historique des scores d'un utilisateur.
   - **Interaction backend** : Récupérer les scores enregistrés d'un utilisateur spécifique pour montrer l'évolution des performances.
   - **EndPoint API** :
     - `GET /user-scores` (récupérer l'historique des scores d'un utilisateur)

### Étapes à suivre

1. **Création du modèle utilisateur** :
   - Créer un modèle pour stocker les informations de base des utilisateurs (nom, email, avatar, etc.).

2. **Implémentation de l'authentification** :

3. **Stockage des scores** :
   - Créer un modèle pour enregistrer les scores des utilisateurs.

4. **Classements et API** :
   - Créer des endpoints pour soumettre les scores et récupérer les classements globaux ou spécifiques.
   - **Routes API** :
     - `POST /score` pour soumettre un score.
     - `GET /leaderboard` pour récupérer les meilleurs scores.
     - `GET /user-scores` pour l'historique d'un utilisateur.