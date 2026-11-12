# ADR 0001 — Choix de la stack technique pour EPIck’em

- Status: Accepted
- Date: 2026-11-12

## Contexte

Nous devons construire une plateforme web de gestion de tournois et de pronostics orientée e-sport. Le projet est pédagogique et ne part d’aucune base existante. Nous devons livrer un dépôt propre, des conventions de travail claires, une base de données solide et un environnement local facile à reproduire.

Le produit couvre plusieurs besoins :

- gestion de tournois internes et importés ;
- inscriptions en solo ou en équipe ;
- résultats et arbre de compétition ;
- pronostics sur les matchs ;
- Pick’em personnalisés ;
- classements et dashboard en direct.

Nous devons donc choisir une pile technique qui soit suffisamment robuste pour la logique métier et assez simple pour un projet de taille académique, avec un faible coût de mise en place et une maintenance gérable.

## Décision

Nous retenons la stack suivante :

- Next.js 16 + React 19 + TypeScript ;
- Prisma ORM + PostgreSQL ;
- Docker Compose pour l’environnement de développement ;
- Tailwind CSS pour l’UI ;
- Biome pour le lint et le format ;
- GitHub Actions pour la CI ;
- pnpm comme gestionnaire de paquets.

## Pourquoi cette décision

### Next.js + React + TypeScript

Cette combinaison donne une base moderne et cohérente pour un projet full-stack web. Elle permet de structurer le front et les routes API dans le même dépôt, sans repartir d’une architecture complètement artisanale.

### Prisma + PostgreSQL

Le cœur du produit repose sur des relations complexes : tournois, joueurs, équipes, stages, matchs, résultats, pronostics, classement et Pick’em. Prisma offre une modélisation claire des données, une validation forte autour du schéma et un accès typé à la base.

PostgreSQL est bien adapté à ce type de modèle relationnel et à la gestion d’un volume de données qui va croître avec les tournois et les pronostics.

### Docker Compose

La base de données locale doit être simple à lancer pour tous les contributeurs. Docker permet de reproduire un environnement cohérent sans dépendre d’une installation locale fragile de PostgreSQL.

### Tailwind CSS

Tailwind est pratique pour construire rapidement des interfaces lisibles et cohérentes, surtout dans un projet où les écrans admin, public et dashboard doivent être propres sans trop de friction de design.

### Biome + CI

Le dépôt doit rester propre et régulier. Biome permet de normaliser le formatage et les vérifications de qualité, tandis que GitHub Actions assure que ces contrôles sont exécutés automatiquement sur les changements.

## Conséquences

### Avantages

- architecture cohérente et rapide à mettre en place ;
- modèle de données structuré dès le départ ;
- excellent point de départ pour un projet de taille pédagogique ;
- documentation technique plus simple à maintenir ;
- bonne compatibilité avec les principes de projet Epitech (qualité, CI, dépôt propre).

### Inconvénients / risques

- la stack est plus lourde qu’une application minimale ;
- Prisma 8 est encore en version release candidate, donc il faut rester attentif aux changements et versions ;
- il faut garder une discipline de modélisation pour éviter un monolithe trop vite sans séparation claire des responsabilités.

## Alternatives envisagées

### Node.js + Express + PostgreSQL

Cette solution est viable, mais elle impose davantage de travail sur le front et la structure globale. Elle est moins naturelle pour un projet moderne avec des routes API et des écrans dans le même dépôt.

### Supabase

Très rapide à initialiser, mais moins adapté à une architecture où l’on veut maîtriser la logique métier, les modèles Prisma et la structure du dépôt de manière pédagogique et explicite.

### Python + FastAPI + frontend séparé

Intéressant pour les règles métier, mais moins cohérent avec un environnement front moderne et un projet full-stack unifié dans le même dépôt.

## Conclusion

Cette stack est un bon équilibre entre robustesse, rapidité de démarrage et qualité de développement. Elle donne un socle fiable pour construire le cœur fonctionnel d’EPIck’em, tout en restant suffisamment simple pour évoluer avec le projet.
