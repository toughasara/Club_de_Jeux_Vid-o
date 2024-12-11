
-- Requêtes de Base

--  Lister les informations de tous les membres 
SELECT pseudo, email, date_inscription 
FROM membres

-- Afficher la liste des jeux disponibles
SELECT titre, genre, studio 
FROM jeux

-- Afficher les détails d'un tournoi
SELECT * 
FROM tournoi 
WHERE nom_tournoi = 'Tournoi Witcher'

-- Lister les emprunts en cours
SELECT membres.pseudo, jeux.titre 
FROM emprunts, membres, jeux
WHERE emprunts.id_membre = membres.id_membre
AND emprunts.id_jeu = jeux.id_jeu
AND emprunts.date_retour_reelle IS NULL





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
WHERE abonnement.type_abonnement = 'annuel'

-- les jeux empruntés par un membre spécifique
SELECT jeux.titre
from emprunts
JOIN membres ON emprunts.id_membre = membres.id_membre
JOIN jeux ON emprunts.id_jeu = jeux.id_jeu
WHERE membres.pseudo = 'Alice Martin'

-- les emprunts, en incluant le pseudo du membre et les informations sur le jeu
SELECT membres.pseudo, jeux.titre, jeux.studio
from emprunts
LEFT JOIN membres ON emprunts.id_membre = membres.id_membre
LEFT JOIN jeux ON emprunts.id_jeu = jeux.id_jeu

-- la liste des membres et le type d'abonnement auquel ils sont associés.
SELECT membres.pseudo, abonnement.type_abonnement
FROM membres
LEFT JOIN abonnement ON abonnement.id_membre = membres.id_membre




-- Requêtes avec Agrégation

-- le nombre total de jeux disponibles par genre.
SELECT 
    genre, 
    COUNT(*) AS total_jeux
FROM 
    jeux
GROUP BY 
    genre

-- le tournoi avec le plus grand nombre de participants 
SELECT 
    tournoi.nom_tournoi,
    COUNT(participons.id_participons) AS nombre_participants
FROM 
    tournoi
LEFT JOIN 
    participons ON tournoi.id_tournoi = participons.id_tournoi
GROUP BY 
    tournoi.id_tournoi
ORDER BY 
    nombre_participants DESC
LIMIT 1

-- le nombre d'emprunts réalisés par chaque membre.
SELECT 
    membres.pseudo,
    COUNT(emprunts.id_emprunt) AS nombre_emprunts
FROM 
    membres
LEFT JOIN 
    emprunts ON membres.id_membre = emprunts.id_membre
GROUP BY 
    membres.id_membre, membres.pseudo
ORDER BY 
    nombre_emprunts DESC




-- Requêtes avec Filtres et Tri

-- Afficher les jeux sortis après une certaine année, triés par ordre alphabétique
SELECT 
    titre, studio, annee_sortie
FROM 
    jeux
WHERE 
    annee_sortie > 2020
ORDER BY 
    titre ASC

-- Trouver les membres qui ont emprunté un jeu, mais ne l'ont pas encore rendu
SELECT 
    membres.id_membre, membres.pseudo, emprunts.id_emprunt, emprunts.date_emprunt
FROM 
    membres
JOIN 
    emprunts ON membres.id_membre = emprunts.id_membre
WHERE 
    emprunts.date_retour_reelle IS NULL 

-- Lister les tournois ayant eu lieu entre deux dates spécifiques
SELECT 
    nom_tournoi, date_tournoi
FROM 
    tournoi
WHERE 
    date_tournoi BETWEEN '2023-07-01' AND '2023-12-31'

--  les membres avec plusieurs emprunts actifs
SELECT 
    membres.pseudo
FROM 
    membres
JOIN 
    emprunts ON membres.id_membre = emprunts.id_membre
WHERE 
    emprunts.date_retour_reelle IS NULL
    OR emprunts.date_retour_prevue > CURDATE()
GROUP BY 
    membres.id_membre, membres.pseudo
HAVING 
    COUNT(emprunts.id_emprunt) > 1

