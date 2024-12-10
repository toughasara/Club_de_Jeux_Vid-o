CREATE DATABASE sql_club_jeux;
USE sql_club_jeux;
CREATE TABLE membres (
    id_membre INT AUTO_INCREMENT PRIMARY KEY,
    pseudo VARCHAR(100),
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    date_inscription DATE
);

CREATE TABLE abonnement (
    id_abonnement INT AUTO_INCREMENT PRIMARY KEY,
    id_membre INT,
    type_abonnement VARCHAR(50),
    date_debut DATE,
    date_fin DATE,
    FOREIGN KEY (id_membre) REFERENCES membres(id_membre)
);

CREATE TABLE jeux (
    id_jeu INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(100),
    studio VARCHAR(100),
    annee_sortie YEAR,
    genre VARCHAR(50),
    multijoueur BOOLEAN
);

CREATE TABLE tournoi (
    id_tournoi INT AUTO_INCREMENT PRIMARY KEY,
    id_jeu INT,
    nom_tournoi VARCHAR(100),
    date_tournoi DATE,
    recompense DECIMAL(10, 2),
    FOREIGN KEY (id_jeu) REFERENCES jeux(id_jeu)
);

CREATE TABLE emprunts (
    id_emprunt INT AUTO_INCREMENT PRIMARY KEY,
    id_membre INT,
    id_jeu INT,
    date_emprunt DATE,
    date_retour_prevue DATE,
    date_retour_reelle DATE DEFAULT NULL,
    FOREIGN KEY (id_membre) REFERENCES membres(id_membre),
    FOREIGN KEY (id_jeu) REFERENCES jeux(id_jeu)
);

CREATE TABLE participons (
    id_participons INT AUTO_INCREMENT PRIMARY KEY,
    id_membre INT,
    id_tournoi INT,
    score INT,
    rang INT,
    FOREIGN KEY (id_membre) REFERENCES membres(id_membre),
    FOREIGN KEY (id_tournoi) REFERENCES tournoi(id_tournoi)
);

INSERT INTO membres (pseudo, name, email, date_inscription) VALUES
('Gamer01', 'Alice Martin', 'alice.martin@example.com', '2023-05-01'),
('ProPlayer', 'Bob Durand', 'bob.durand@example.com', '2023-06-15'),
('NoobMaster', 'Clara Bernard', 'clara.bernard@example.com', '2023-07-10'),
('Speedy', 'David Fabre', 'david.fabre@example.com', '2023-08-20'),
('Shadow', 'Emma Lefevre', 'emma.lefevre@example.com', '2023-09-12'),
('DragonSlayer', 'Franck Dupont', 'franck.dupont@example.com', '2023-10-05');

INSERT INTO abonnement (id_membre, type_abonnement, date_debut, date_fin) VALUES
(1, 'Mensuel', '2023-05-01', '2023-05-31'),
(2, 'Annuel', '2023-06-01', '2024-05-31'),
(3, 'Mensuel', '2023-07-01', '2023-07-31'),
(4, 'Mensuel', '2023-08-01', '2023-08-31'),
(5, 'Annuel', '2023-09-01', '2024-08-31'),
(6, 'Mensuel', '2023-10-01', '2023-10-31');

INSERT INTO jeux (titre, studio, annee_sortie, genre, multijoueur) VALUES
('The Witcher 3', 'CD Projekt Red', 2015, 'RPG', TRUE),
('Minecraft', 'Mojang Studios', 2011, 'Sandbox', TRUE),
('FIFA 23', 'EA Sports', 2022, 'Sport', TRUE),
('Cyberpunk 2077', 'CD Projekt Red', 2020, 'RPG', FALSE),
('Among Us', 'InnerSloth', 2018, 'Party', TRUE),
('The Legend of Zelda', 'Nintendo', 2017, 'Adventure', FALSE);

INSERT INTO tournoi (id_jeu, nom_tournoi, date_tournoi, recompense) VALUES
(1, 'Tournoi Witcher', '2023-06-10', 500.00),
(2, 'Minecraft Build Battle', '2023-07-20', 300.00),
(3, 'FIFA Championship', '2023-08-15', 1000.00),
(4, 'Cyberpunk Speedrun', '2023-09-05', 400.00),
(5, 'Among Us Marathon', '2023-10-25', 250.00),
(6, 'Zelda Quest', '2023-11-10', 600.00);

INSERT INTO emprunts (id_membre, id_jeu, date_emprunt, date_retour_prevue, date_retour_reelle) VALUES
(1, 1, '2023-05-05', '2023-05-12', '2023-05-11'),
(2, 2, '2023-06-20', '2023-06-27', '2023-06-25'),
(3, 3, '2023-07-15', '2023-07-22', NULL),
(4, 4, '2023-08-05', '2023-08-12', NULL),
(5, 5, '2023-09-10', '2023-09-17', '2023-09-16'),
(6, 6, '2023-10-01', '2023-10-08', '2023-10-07');

INSERT INTO participons (id_membre, id_tournoi, score, rang) VALUES
(1, 1, 1500, 1),
(2, 2, 1200, 2),
(3, 3, 800, 3),
(4, 4, 1000, 2),
(5, 5, 2000, 1),
(6, 6, 500, 4);
