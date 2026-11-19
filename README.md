# Projet SQL DataLendo - Analyse des Ventes et Segmentation Clients

## Objectif du projet

L'objectif de ce projet était de mettre en pratique les fondamentaux de SQL à travers l'analyse d'une entreprise de vente de produits électroniques (DataLendo).

Les données étaient réparties dans quatre tables :

- `clients`
- `produits`
- `ventes`
- `paiements`

Au cours du projet, nous avons créé la base de données, importé les données CSV, réalisé des contrôles qualité, construit des indicateurs de performance (KPI) et réalisé une segmentation RFM des clients.

---

# Compétences SQL mises en pratique

## Exploration des données

Utilisation de :

```sql
SELECT
DISTINCT
COUNT()
ORDER BY
LIMIT
```

Exemples :

- Nombre total de clients
- Nombre total de ventes
- Nombre total de produits
- Nombre total de paiements
- Liste des pays représentés
- Liste des catégories de produits
- Liste des méthodes de paiement

---

## Contrôle qualité des données

Vérification :

- des doublons
- des valeurs manquantes (NULL)
- des incohérences entre ventes et paiements

Fonctions utilisées :

```sql
GROUP BY
HAVING
IS NULL
COUNT()
```

---

## Calcul des KPI

Indicateurs étudiés :

- Chiffre d'affaires total
- Chiffre d'affaires encaissé
- Nombre de ventes
- Nombre de paiements réussis
- Vente moyenne
- Vente maximale
- Vente minimale

Fonctions utilisées :

```sql
SUM()
AVG()
MIN()
MAX()
COUNT()
```

---

## Analyse commerciale

Analyses réalisées :

- Chiffre d'affaires par pays
- Chiffre d'affaires par mois
- Chiffre d'affaires par méthode de paiement
- Chiffre d'affaires par catégorie de produits
- Top 10 des produits les plus rentables
- Top 10 des meilleurs clients

Utilisation des concepts :

```sql
JOIN
GROUP BY
ORDER BY
SUM()
```

---

## Segmentation RFM

### R = Recency

Nombre de jours depuis le dernier achat.

### F = Frequency

Nombre de commandes passées.

### M = Monetary

Montant total dépensé.

Objectif :

Identifier :

- les clients VIP
- les clients fidèles
- les clients occasionnels
- les clients à risque

---

# Résultats principaux

## Chiffre d'affaires

### KPI global

- Chiffre d'affaires total : **27 millions**
- Chiffre d'affaires encaissé : **23 millions**

Cela signifie qu'environ :

```text
4 millions de chiffre d'affaires
n'ont jamais été encaissés.
```

Le taux de paiement réussi est d'environ :

```text
85 %
```

---

## Paiements

Sur environ :

```text
15 000 commandes
```

près de :

```text
2 250 paiements
```

ont échoué.

### Insight

Les paiements échoués représentent une perte financière importante.

### Recommandation

Mettre en place :

- des relances automatiques
- des rappels par email
- une proposition automatique d'une autre méthode de paiement

Une augmentation de seulement :

```text
85 % → 90 %
```

de réussite permettrait d'ajouter environ :

```text
+ 1,4 million
```

de chiffre d'affaires sans acquérir un seul nouveau client.

---

## Produits

### Insight

Les Laptops et les TV génèrent la majorité du chiffre d'affaires.

À eux seuls, ils représentent plus des trois quarts des revenus de l'entreprise.

À l'inverse :

- les accessoires se vendent correctement
- mais génèrent peu de revenus

Neuf des dix produits les plus rentables sont des laptops.

### Recommandations

- Sécuriser les stocks des laptops les plus demandés.
- Éviter toute rupture sur les références phares.
- Prioriser les campagnes marketing sur les laptops et les TV.
- Continuer à proposer les accessoires sous forme de ventes additionnelles.

---

## Saisonnalité des ventes

### Insight

Entre janvier et avril :

```text
≈ 2,8 millions / mois
```

À partir de juin :

```text
≈ 1,4 million / mois
```

Les ventes sont divisées par deux et ne remontent pas par la suite.

### Recommandations

Identifier les raisons de cette baisse :

- problème de stock
- baisse marketing
- hausse des prix
- augmentation de la concurrence
- changement du comportement client

Prévoir des campagnes spécifiques pour :

- rentrée scolaire
- Black Friday
- fêtes de fin d'année

---

## Clients

### Insight

Le client :

```text
ID 786
```

est le client le plus précieux :

- 10 commandes
- près de 32 000 de dépenses

Les dix meilleurs clients représentent une valeur élevée pour l'entreprise.

Cependant, l'analyse RFM montre que plusieurs des meilleurs clients n'ont pas acheté récemment.

### Recommandations

Mettre en place :

- programme VIP
- remises exclusives
- campagnes de réactivation
- suivi personnalisé des plus gros clients

Une attention particulière devrait être accordée au client 786.

---

## Répartition géographique

### Insight

Les marchés sont globalement équilibrés.

- Sénégal = premier marché
- Cameroun = dernier marché

L'écart reste relativement faible.

L'Afrique représente plus de 60 % de l'activité commerciale.

### Recommandations

- Renforcer les investissements sur les marchés africains.
- Poursuivre le développement du Mobile Money.
- Adapter les campagnes marketing aux spécificités locales.

---

## Paiements

### Insight

Les clients utilisent :

- Carte bancaire
- Mobile Money
- PayPal

dans des proportions relativement équilibrées.

### Recommandations

Maintenir les trois solutions de paiement.

Analyser plus finement :

- le taux d'échec par méthode
- le montant encaissé par méthode
- les préférences selon les pays

---

# Conclusions générales

Cette analyse montre que DataLendo possède un modèle économique solide mais présente plusieurs opportunités d'amélioration.

Les principales priorités identifiées sont :

1. Réduire les échecs de paiement.
2. Comprendre la baisse des ventes observée à partir du mois de juin.
3. Fidéliser les meilleurs clients.
4. Sécuriser l'approvisionnement des laptops.
5. Développer les ventes additionnelles d'accessoires.

Les produits informatiques, en particulier les laptops, constituent aujourd'hui le principal moteur de croissance de l'entreprise.

---

# Vérifications à effectuer avant validation finale

Avant de finaliser les conclusions :

- Vérifier le calcul de la récence (RFM).
- Confirmer que la baisse des ventes après juin est réelle.
- Étudier les échecs de paiement par pays et par méthode de paiement.
- Uniformiser les analyses entre ventes totales et ventes effectivement encaissées.

---

## Technologies utilisées

- PostgreSQL
- pgAdmin
- SQL
- Analyse RFM
- Agrégations SQL (`SUM`, `AVG`, `COUNT`, `MIN`, `MAX`)
- Jointures (`JOIN`)
- Segmentation client

---

## Auteur

Yves N'dri
Projet réalisé dans le cadre de l'apprentissage de SQL et de l'analyse de données décisionnelles.
