# ADR 0002 — Modèle de données du cœur métier EPIck’em

- Status: In Progress
- Date: 2026-11-12

## Contexte

Le produit central de EPIck’em repose sur une logique de tournoi et de pronostics. Il faut donc modéliser les objets métiers suivants :

- les utilisateurs et leurs rôles ;
- les jeux supportés ;
- les tournois ;
- les équipes et leurs membres ;
- les phases et formats de compétition ;
- les matchs et leurs résultats ;
- les pronostics du public ;
- les questions Pick’em et leurs réponses ;
- les classements.

## Décision

Nous allons structurer le modèle de données autour de domaines métier distincts :

- utilisateurs et rôles ;
- jeux et tournois ;
- équipes et participants ;
- étapes / phases de tournoi ;
- matchs et résultats ;
- pronostics sur les matchs ;
- Pick’em personnalisé ;
- classements calculés à partir des résultats.

La base sera relationnelle, avec Prisma comme source de vérité du schéma.

## Modèle cible (première idée)

Le schéma ci-dessous est un premier modèle métier qui peut être modifié dans le futur :

```prisma
generator client {
  provider = "prisma-client"
  output   = "../lib/generated/prisma"
}

datasource db {
  provider = "postgresql"
}

enum UserRole {
  ADMIN
  PLAYER
  SPECTATOR
}

enum TournamentVisibility {
  PUBLIC
  PRIVATE
}

enum StageType {
  GROUP_STAGE
  ELIMINATION
}

enum MatchStatus {
  SCHEDULED
  LIVE
  FINISHED
  CANCELLED
}

model User {
  id                 String   @id @default(cuid())
  email              String   @unique
  username           String   @unique
  role               UserRole @default(SPECTATOR)
  passwordHash       String
  confirmed          Boolean  @default(false)
  deletionScheduledAt DateTime?
  createdAt          DateTime @default(now())
  updatedAt          DateTime @updatedAt

  tournaments Tournament[]
  teams       TeamMember[]
  predictions Prediction[]
  sessions           Session[]
  serviceConnections ServiceConnection[]
  widgets            Widget[]
  verificationToken  VerificationToken[]

  @@index([deletionScheduledAt])
}
}

model Game {
  id          String       @id @default(cuid())
  name        String
  description String?
  tournaments Tournament[]
}

model Tournament {
  id          String               @id @default(cuid())
  name        String
  description String?
  visibility  TournamentVisibility @default(PUBLIC)
  startsAt    DateTime?
  endsAt      DateTime?
  createdAt   DateTime             @default(now())
  updatedAt   DateTime             @updatedAt

  game       Game   @relation(fields: [gameId], references: [id])
  gameId     String
  organizer  User   @relation(fields: [organizerId], references: [id])
  organizerId String

  stages     Stage[]
  teams      Team[]
  questions  PickEmQuestion[]
}

model Team {
  id          String   @id @default(cuid())
  name        String
  tag         String?
  createdAt   DateTime @default(now())

  tournament  Tournament @relation(fields: [tournamentId], references: [id])
  tournamentId String

  members     TeamMember[]
  homeMatches Match[]    @relation("HomeTeam")
  awayMatches Match[]    @relation("AwayTeam")
}

model TeamMember {
  id      String @id @default(cuid())
  user    User   @relation(fields: [userId], references: [id])
  userId  String
  team    Team   @relation(fields: [teamId], references: [id])
  teamId  String

  @@unique([userId, teamId])
}

model Stage {
  id          String   @id @default(cuid())
  name        String
  type        StageType
  order       Int

  tournament  Tournament @relation(fields: [tournamentId], references: [id])
  tournamentId String

  matches     Match[]
}

model Match {
  id          String      @id @default(cuid())
  status      MatchStatus @default(SCHEDULED)
  scheduledAt DateTime?
  stage       Stage       @relation(fields: [stageId], references: [id])
  stageId     String

  homeTeam    Team        @relation("HomeTeam", fields: [homeTeamId], references: [id])
  homeTeamId  String
  awayTeam    Team        @relation("AwayTeam", fields: [awayTeamId], references: [id])
  awayTeamId  String

  result      MatchResult?
  predictions Prediction[]
}

model MatchResult {
  id          String   @id @default(cuid())
  match       Match    @relation(fields: [matchId], references: [id])
  matchId     String   @unique
  homeScore   Int?
  awayScore   Int?
  winnerTeamId String?
  notes       String?
}

model Prediction {
  id        String   @id @default(cuid())
  user      User     @relation(fields: [userId], references: [id])
  userId    String
  match     Match    @relation(fields: [matchId], references: [id])
  matchId   String
  homeScore Int?
  awayScore Int?
  createdAt DateTime @default(now())

  @@unique([userId, matchId])
}

model Session {
  id        String   @id @default(cuid())
  token     String   @unique
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  expiresAt DateTime
  createdAt DateTime @default(now())
}

enum ServiceProvider {
  DISCORD
  GOOGLE
  STEAM
  TWITCH
}

model ServiceConnection {
  id                String          @id @default(cuid())
  provider          ServiceProvider
  userId            String
  user              User            @relation(fields: [userId], references: [id], onDelete: Cascade)
  providerAccountId String
  displayName       String?
  avatarUrl         String?
  accessToken       String?
  refreshToken      String?
  expiresAt         DateTime?
  scope             String?
  createdAt         DateTime        @default(now())
  updatedAt         DateTime        @updatedAt

  @@unique([userId, provider])
}

model VerificationToken {
  id        String   @id @default(cuid())
  token     String   @unique
  userId    String
  user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  expiresAt DateTime
  createdAt DateTime @default(now())
}

model Widget {
  id              String
  userId          String
  user            User     @relation(fields: [userId], references: [id], onDelete: Cascade)
  type            String
  title           String
  refreshInterval Int
  config          Json     @default("{}")
  position        Int
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt

  @@id([userId, id])
  @@index([userId, position])
}

model PickEmQuestion {
  id          String        @id @default(cuid())
  tournament  Tournament    @relation(fields: [tournamentId], references: [id])
  tournamentId String
  question    String
  closesAt    DateTime?
  options     PickEmChoice[]
}

model PickEmChoice {
  id          String          @id @default(cuid())
  question    PickEmQuestion  @relation(fields: [questionId], references: [id])
  questionId  String
  label       String
  isCorrect   Boolean?
}
```

## Pourquoi ce modèle

- il correspond bien aux règles du produit : tournois, équipes, matches, pronostics et Pick’em ;
- il réduit le risque de faire un modèle trop générique ;
- il donne une base de travail exploitable pour le MVP ;
- il reste compréhensible et modifiable au fur et à mesure de l’avancement ;
- il permet d’ajouter ensuite des fonctionnalités plus avancées (classements détaillés, inscriptions avec validation, notifications, etc.).

## Conséquences

### Avantages

- les relations métier sont claires ;
- la logique de tournoi et de pronostics est plus simple à implémenter ensuite ;
- le schéma constitue une base de travail pour l’API, les pages admin et le dashboard public.

### Limites de cette première version

- le modèle ne couvre pas encore les cas avancés (double élimination, round robin complexe, groupes privés, etc.) ;
- les classements ne sont pas encore décrits comme entité séparée, ce qui pourra être ajouté plus tard si besoin ;
- la gestion de données importées depuis start.gg devra être pensée séparément dans la couche de connecteurs.

## Évolution prévue

À mesure que le produit avance, ce modèle pourra évoluer pour inclure :

- inscriptions ouvertes / liste d’attente ;
- groupes privés entre amis ;
- classements détaillés par tournoi ;
- statuts de match plus avancés ;
- modèles de Pick’em avec réponses multiples ;
- connecteurs externes et cache de données importées ;
- notifications et badges.

## Conclusion

Le modèle de données doit refléter le cœur du produit, pas un exemple générique d’application. Cette version est un bon point d’entrée pour la construction fonctionnelle de EPIck’em et constitue une base cohérente pour les prochaines itérations.
