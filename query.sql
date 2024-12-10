
-- Requêtes de Base

--  Lister les informations de tous les membres 
SELECT pseudo, email, date_inscription 
FROM membres;

-- Afficher la liste des jeux disponibles
SELECT titre, genre, studio 
FROM jeux;

-- Afficher les détails d'un tournoi
SELECT * 
FROM tournoi 
WHERE nom_tournoi = 'Tournoi Witcher'; 

-- Lister les emprunts en cours
SELECT membres.pseudo, jeux.titre 
FROM emprunts, membres, jeux
WHERE emprunts.id_membre = membres.id_membre
AND emprunts.id_jeu = jeux.id_jeu
AND emprunts.date_retour_reelle IS NULL;





-- Requêtes avec Jointures

-- les membres ayant participé à un tournoi
SELECT membres.pseudo, tournoi.nom_tournoi, participons.rang
FROM participons
JOIN membres ON participons.id_membre = membres.id_membre
JOIN tournoi ON participons.id_tournoi = tournoi.id_tournoi

-- les membres qui ont souscrit à un abonnement annuel
SELECT membres.*
FROM membres
JOIN abonnement ON membres.id_membre = abonnement.id_membre
WHERE abonnement.type_abonnement = 'annuel';

-- les jeux empruntés par un membre spécifique
SELECT jeux.titre
from emprunts
JOIN membres ON emprunts.id_membre = membres.id_membre
JOIN jeux ON emprunts.id_jeu = jeux.id_jeu
WHERE membres.pseudo = 'Alice Martin';

-- les emprunts, en incluant le pseudo du membre et les informations sur le jeu
SELECT membres.pseudo, jeux.titre, jeux.studio
from emprunts
LEFT JOIN membres ON emprunts.id_membre = membres.id_membre
LEFT JOIN jeux ON emprunts.id_jeu = jeux.id_jeu

-- la liste des membres et le type d'abonnement auquel ils sont associés.
SELECT membres.pseudo, abonnement.type_abonnement
FROM membres
LEFT JOIN abonnement ON abonnement.id_membre = membres.id_membre;





-- Requêtes avec Agrégation

-- le nombre total de jeux disponibles par genre.

