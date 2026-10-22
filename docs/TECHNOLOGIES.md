# Technologies

## Summary

This file explain the stack choice of our project.
Versions are the ones pinned in `src/package.json` (and `docker-compose.yml` for PostgreSQL).

## Stack

| Name | Version | Description |
| - | - | - |
| Next.js | 16.4.2 | Fullstack React framework (App Router, Turbopack). Pages in `src/app/`, APIs in `src/app/api/` |
| React | 19.3.0 | UI library |
| TypeScript | ^5 | Typed JavaScript, strict mode |
| Tailwind CSS | ^4 | Utility-first styling, wired through `@tailwindcss/turbopack` |
| Prisma ORM | 8.0.0-rc.24 (CLI) | Data contract (`src/prisma/contract.prisma`), migrations and typed queries |
| `@prisma/orm-postgres` | 8.0.0-rc.20 | Prisma 8 PostgreSQL runtime and config |
| PostgreSQL | 17 (Docker image) | Database. PostgreSQL >= 15 is required |
| Docker Compose | - | Runs the local database (`docker-compose.yml`, service `db`) |
| Node.js | 22 | Runtime (version used in CI) |
| pnpm | 12.1.0 | Package manager (pinned through `packageManager`) |
| Biome | 2.4.2 | Linter and formatter (4 spaces, organize imports) |
| Lefthook | ^2.2.2 | Git hooks: Biome on commit, typecheck and build on push, commit message check |
| GitHub Actions | - | CI (`ci.yml`) and repo hygiene (`hygiene.yml`) |
| dotenv | ^18.0.8 | Loads `.env` for Prisma config and client |
| tsx | ^4.23.15 | Runs TypeScript scripts |

## Notes

- Prisma 8 is still a release candidate: versions are pinned exactly and the `@prisma/orm-*`
  packages are excluded from pnpm's `minimumReleaseAge` in `src/pnpm-workspace.yaml`.
  When upgrading, keep `prisma`, `@prisma/orm-postgres` and the `overrides` entry in sync.
