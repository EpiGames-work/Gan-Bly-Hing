# Contributing

## Summary

Short version of how we work. <br>
Details on folders and naming: [docs/ORGANIZATION.md](docs/ORGANIZATION.md) <br>

## One-time setup

Requirements: Node.js 22, pnpm 12 (`corepack enable`), Docker.

```bash
git clone <repo-url> && cd Gan-Bly-Hing/src   # every pnpm command runs from `src/`
cp .env.example .env                          # local database credentials
pnpm install                                  # also installs the git hooks (lefthook)
pnpm db                                       # starts PostgreSQL (docker compose)
pnpm orm                                      # emits the contract and applies migrations
pnpm dev                                      # http://localhost:1999
```

`pnpm dev:full` chains install, database, migrations and dev server in one go.

## Daily workflow

1. Create a branch from `dev`, e.g. `feat/login`.
2. Code. The formatter and linter run on staged files at commit time; run `pnpm check` to fix everything manually.
3. If you changed `prisma/contract.prisma`:
    - `pnpm contract:emit` regenerates `contract.json` and `contract.d.ts` (commit both)
    - `pnpm orm:update <name>` plans a new migration
    - `pnpm orm` applies pending migrations
    - `pnpm orm:push` pushes the contract directly to your local database (no migration, quick prototyping only)
4. Commit with the [commit convention](docs/COMMIT_CONVENTION.md), e.g. `feat: auth: Add password reset flow`.
5. Push (hooks run `tsc` and `next build`), open a PR using the template, and link the issue.

Useful commands (from `src/`):

| Command | What it does |
| - | - |
| `pnpm dev` | Dev server on port 1999 |
| `pnpm lint` / `pnpm format` / `pnpm check` | Biome check / format / check and fix |
| `pnpm typecheck` | `next typegen` then `tsc --noEmit` |
| `pnpm build` / `pnpm start` | Production build / server |
| `pnpm db` | Start the local PostgreSQL container |

## Commit convention

We follow a custom version of GitHub's conventional commit,
it is described in [docs/COMMIT_CONVENTION.md](docs/COMMIT_CONVENTION.md)

## Changelogs

Remember to update the changelogs, see [CHANGELOG.md](CHANGELOG.md), on each meaningful merge into the `main` branch.

## What CI checks

For context anything with a `?` at the end is optional

| Check | Catches | Blocks? |
| - | - | - |
| Lint & format | Style issues (`biome check`) | Yes |
| Typecheck | Type errors (`tsc --noEmit`) | Yes |
| Build | Broken `next build` | Yes |
| Prisma contract | `contract.prisma` changed without `pnpm contract:emit` | Yes |
| Commit convention | Commit subjects not matching `docs/COMMIT_CONVENTION.md` | Yes |
| Conflict markers | Leftover `<<<<<<<` / `>>>>>>>` | Yes |

## Troubleshooting

| Problem | Fix |
| - | - |
| `DATABASE_URL is not set` | Copy `src/.env.example` to `src/.env` |
| Cannot connect to the database | Run `pnpm db` and check `docker compose ps`; make sure nothing else uses port 5432 |
| `pnpm orm` says to try `orm:push` | No migration exists yet: use `pnpm orm:update <name>` to create one, or `pnpm orm:push` locally |
| CI "Prisma contract" fails | Run `pnpm contract:emit` and commit the changes in `src/prisma/` |
| `Cannot find name 'LayoutProps'` | Route types are generated: run `pnpm typecheck` (runs `next typegen`) instead of bare `tsc` |
| Commit rejected by the hook | Subject must match `[type]: {scope}: Capitalized content`, see the commit convention |
| pnpm refuses a fresh Prisma 8 release | Add it to `minimumReleaseAgeExclude` in `src/pnpm-workspace.yaml` |

## Reporting bugs and tasks

Use the issue template (Issues -> New issue).
