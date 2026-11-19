/*
creattion des differentes tables
 ventes produits cliens et paiement
*/

CREATE TABLE clients (
    id_client INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    pays VARCHAR(50),
    ville VARCHAR(50),
    date_inscription DATE,
    canal_acquisition VARCHAR(50)
);

CREATE TABLE produits (
    id_produit INT PRIMARY KEY,
    nom_produit VARCHAR(100) NOT NULL,
    categorie VARCHAR(50),
    prix NUMERIC(10,2),
    marge NUMERIC(10,2),
    stock_initial INT
);

CREATE TABLE ventes (
    id_vente INT,
    id_client INT,
    id_produit INT,
    date_vente DATE,
    quantite INT,
    montant_total NUMERIC(12,2),
    channel VARCHAR(50)
);

CREATE TABLE paiements (
    id_paiement INT,
    id_vente INT,
    methode VARCHAR(50),
    statut VARCHAR(30)
);

-- 10 premiers produits
SELECT *
FROM produits
LIMIT 10;

-- 10 premiers produits
SELECT *
FROM produits
LIMIT 10;

-- 10 premières ventes
SELECT *
FROM ventes
LIMIT 10;

-- 10 premiers paiements
SELECT *
FROM paiements
LIMIT 10;

-- nbre totale de clients
SELECT COUNT(*) AS nombre_clients
FROM clients;

--nbre totale de Ventes
SELECT COUNT(*) AS nombre_ventes
FROM ventes;


--nbre totale de preoduits
SELECT COUNT(*) AS nombre_produits
FROM produits;

--nbre totale de preoduits
SELECT COUNT(*) AS nombre_paiements
FROM paiements;

--pour tout compter

SELECT 'Clients' AS table_name, COUNT(*) AS total
FROM clients

UNION ALL

SELECT 'Produits', COUNT(*)
FROM produits

UNION ALL

SELECT 'Ventes', COUNT(*)
FROM ventes

UNION ALL

SELECT 'Paiements', COUNT(*)
FROM paiements;

-- 10 premiers clients
SELECT *
FROM clients
LIMIT 10;

-- 10 premiers produits
SELECT *
FROM produits
LIMIT 10;

-- 10 premières ventes
SELECT *
FROM ventes
LIMIT 10;

-- 10 premiers paiements
SELECT *
FROM paiements
LIMIT 10;

--STEP 3 VERIFIEZ LES COLONNES IMPORTANTES

--TOUT LES PAYS
SELECT DISTINCT pays
FROM clients;

SELECT DISTINCT categorie
FROM produits;

SELECT DISTINCT methode , statut
FROM paiements;

-- STATISTIQUE SIMPLE

SELECT SUM(montant_total) AS montant_total_ventes
FROM ventes;

SELECT AVG(montant_total) AS moyenne_vente
FROM ventes;

SELECT
    MAX(montant_total) AS vente_maximale,
    MIN(montant_total) AS vente_minimale
FROM ventes;

-- nettoyage des donnees

SELECT *
FROM ventes;

-- Nbre de vente reussie
SELECT *
FROM ventes v
JOIN paiements p
    ON v.id_client = p.id_vente
WHERE p.statut = 'Success';

--nbre de paiement reussi

SELECT COUNT(*) AS nombre_paiements_reussis
FROM paiements
WHERE statut = 'Success';

--verifiez les doublons dans les ventes

SELECT
    id_vente,
    COUNT(*) AS nombre_occurrences
FROM ventes
GROUP BY id_vente
HAVING COUNT(*) > 1;

-- verifiez si ya des valeurs nulles ou manquqntes


SELECT
    COUNT(*) FILTER (WHERE id_client IS NULL) AS id_client_null,
    COUNT(*) FILTER (WHERE nom IS NULL) AS nom_null,
    COUNT(*) FILTER (WHERE pays IS NULL) AS pays_null,
    COUNT(*) FILTER (WHERE ville IS NULL) AS ville_null,
    COUNT(*) FILTER (WHERE date_inscription IS NULL) AS date_inscription_null,
    COUNT(*) FILTER (WHERE canal_acquisition IS NULL) AS canal_acquisition_null
FROM clients;

SELECT
    COUNT(*) FILTER (WHERE id_produit IS NULL) AS id_produit_null,
    COUNT(*) FILTER (WHERE nom_produit IS NULL) AS nom_produit_null,
    COUNT(*) FILTER (WHERE categorie IS NULL) AS categorie_null,
    COUNT(*) FILTER (WHERE prix IS NULL) AS prix_null,
    COUNT(*) FILTER (WHERE marge IS NULL) AS marge_null,
    COUNT(*) FILTER (WHERE stock_initial IS NULL) AS stock_initial_null
FROM produits;

--Preparez les colonnes importantes

--total ventes par pays

SELECT
    c.pays,
    SUM(v.montant_total) AS total_ventes
FROM ventes v
JOIN clients c
    ON v.id_client = c.id_client
GROUP BY c.pays
ORDER BY total_ventes DESC;

--REPONDRE AU QUESTIONS BUSINESS

--KPI
-- CA Success
SELECT
    SUM(v.montant_total) AS chiffre_affaires_paiements_reussis
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success';

--chiffre d'affaire /mois

SELECT
    EXTRACT(MONTH FROM v.date_vente) AS mois,
    SUM(v.montant_total) AS chiffre_affaires_success
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY mois
ORDER BY mois;

SELECT
    TO_CHAR(v.date_vente, 'Day') AS jour_semaine,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY jour_semaine
ORDER BY chiffre_affaires DESC;

--methode de payement des chiffre d'affaire

SELECT
    p.methode,
    SUM(v.montant_total) AS chiffre_affaires_success
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY p.methode
ORDER BY chiffre_affaires_success DESC;

SELECT
    p.methode,
    COUNT(*) AS nombre_ventes
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
GROUP BY p.methode
ORDER BY nombre_ventes DESC;

-- Relier les ventes aux clients
-- Calculer le chiffre d'affaires de chaque pays
SELECT
    c.pays,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN clients c
    ON v.id_client = c.id_client
GROUP BY c.pays
ORDER BY chiffre_affaires DESC;

-- Calculer le chiffre d'affaires de chaque canal
SELECT
    channel,
    SUM(montant_total) AS chiffre_affaires
FROM ventes
GROUP BY channel
ORDER BY chiffre_affaires DESC;

-- Conserver uniquement les paiements réussis
-- Calculer le CA encaissé par mois
SELECT
    EXTRACT(MONTH FROM v.date_vente) AS mois,
    SUM(v.montant_total) AS chiffre_affaires_success
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY mois
ORDER BY mois;

-- Relier les ventes aux produits
-- Calculer le CA par produit
SELECT
    p.nom_produit,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN produits p
    ON v.id_produit = p.id_produit
GROUP BY p.nom_produit
ORDER BY chiffre_affaires DESC;

-- Calculer le nombre total d'unités vendues
-- pour chaque catégorie de produit
SELECT
    p.categorie,
    SUM(v.quantite) AS quantite_vendue
FROM ventes v
JOIN produits p
    ON v.id_produit = p.id_produit
GROUP BY p.categorie
ORDER BY quantite_vendue DESC;

-- Calculer le chiffre d'affaires
-- généré par chaque catégorie
SELECT
    p.categorie,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN produits p
    ON v.id_produit = p.id_produit
GROUP BY p.categorie
ORDER BY chiffre_affaires DESC;



-- Analyse RFM par client

SELECT
    id_client,

    -- Nombre de jours depuis le dernier achat
    CURRENT_DATE - MAX(date_vente) AS recence,

    -- Nombre de commandes
    COUNT(*) AS frequence,

    -- Montant total dépensé
    SUM(montant_total) AS montant_depense

FROM ventes

GROUP BY id_client

ORDER BY montant_depense DESC;

--indicateur pour insight

-- Calculer le chiffre d'affaires total
-- en additionnant tous les montants des ventes

SELECT
    SUM(montant_total) AS chiffre_affaires_total
FROM ventes;

-- Calculer le montant moyen
-- d'une transaction

SELECT
    AVG(montant_total) AS moyenne_vente
FROM ventes;

-- Trouver la plus grosse vente
-- et la plus petite vente

SELECT
    MAX(montant_total) AS vente_maximale,
    MIN(montant_total) AS vente_minimale
FROM ventes;

-- Afficher uniquement les ventes
-- dont le paiement est réussi

-- Compter le nombre de paiements réussis

SELECT
    COUNT(*) AS nombre_paiements_reussis
FROM paiements
WHERE statut = 'Success';

-- Calculer le chiffre d'affaires
-- réellement encaissé

SELECT
    SUM(v.montant_total) AS chiffre_affaires_success
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success';

-- Calculer le chiffre d'affaires
-- généré dans chaque pays

SELECT
    c.pays,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN clients c
    ON v.id_client = c.id_client
GROUP BY c.pays
ORDER BY chiffre_affaires DESC;

-- Calculer le chiffre d'affaires
-- des paiements réussis par mois

SELECT
    EXTRACT(MONTH FROM v.date_vente) AS mois,
    SUM(v.montant_total) AS chiffre_affaires_success
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY mois
ORDER BY mois;

-- Identifier les méthodes de paiement
-- qui génèrent le plus de chiffre d'affaires

SELECT
    p.methode,
    SUM(v.montant_total) AS chiffre_affaires_success
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
WHERE p.statut = 'Success'
GROUP BY p.methode
ORDER BY chiffre_affaires_success DESC;


-- Compter le nombre de ventes
-- pour chaque méthode de paiement

SELECT
    p.methode,
    COUNT(*) AS nombre_ventes
FROM ventes v
JOIN paiements p
    ON v.id_vente = p.id_vente
GROUP BY p.methode
ORDER BY nombre_ventes DESC;

-- Afficher les 10 produits générant le plus de chiffre d'affaires

SELECT
    p.nom_produit,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN produits p
    ON v.id_produit = p.id_produit
GROUP BY p.nom_produit
ORDER BY chiffre_affaires DESC
LIMIT 10;

-- Calculer le chiffre d'affaires
-- par catégorie de produit

SELECT
    p.categorie,
    SUM(v.montant_total) AS chiffre_affaires
FROM ventes v
JOIN produits p
    ON v.id_produit = p.id_produit
GROUP BY p.categorie
ORDER BY chiffre_affaires DESC;

-- Identifier les catégories
-- les plus vendues en volume

SELECT
    p.categorie,
    SUM(v.quantite) AS quantite_vendue
FROM ventes v
JOIN produits p
    ON v.id_produit = p.id_produit
GROUP BY p.categorie
ORDER BY quantite_vendue DESC;

-- R = Recency
-- Nombre de jours depuis le dernier achat

-- F = Frequency
-- Nombre total de commandes

-- M = Monetary
-- Montant total dépensé

SELECT
    id_client,

    CURRENT_DATE - MAX(date_vente) AS recence,

    COUNT(*) AS frequence,

    SUM(montant_total) AS montant_depense

FROM ventes

GROUP BY id_client

ORDER BY montant_depense DESC;


-- Top 10 clients ayant le plus de valeur pour l'entreprise
-- R = Recency : nombre de jours depuis le dernier achat
-- F = Frequency : nombre total de commandes
-- M = Monetary : montant total dépensé

SELECT
    id_client,

    -- Nombre de jours depuis le dernier achat
    CURRENT_DATE - MAX(date_vente) AS recence,

    -- Nombre total de commandes
    COUNT(*) AS frequence,

    -- Montant total dépensé
    SUM(montant_total) AS montant_depense

FROM ventes

GROUP BY id_client

-- Trier par montant dépensé du plus élevé au plus faible
ORDER BY montant_depense DESC

-- Afficher uniquement les 10 meilleurs clients
LIMIT 10;

-- Identifier les clients
-- ayant dépensé le plus

SELECT
    id_client,
    SUM(montant_total) AS montant_depense
FROM ventes
GROUP BY id_client
ORDER BY montant_depense DESC
LIMIT 10;


-- Identifier les clients
-- passant le plus de commandes

SELECT
    id_client,
    COUNT(*) AS nombre_commandes
FROM ventes
GROUP BY id_client
ORDER BY nombre_commandes DESC
LIMIT 10;
