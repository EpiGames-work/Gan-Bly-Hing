# Gan-Bly-Hing

## Summary

A simple, all-in-one E-Sport platform
for tourney planning and (fictional) pronostics.

## Stack

Next.js 16 (App Router) + React 19 + TypeScript, Prisma ORM 8 on PostgreSQL,
Tailwind CSS 4, Biome, pnpm. Versions and rationale: [docs/TECHNOLOGIES.md](docs/TECHNOLOGIES.md).

## Getting started

Requirements: Node.js 22, pnpm 12, Docker (for PostgreSQL).

```bash
cd src
cp .env.example .env
pnpm dev:full
```

The app is then available on <http://localhost:1999>.
Step-by-step setup and daily commands: [CONTRIBUTING.md](CONTRIBUTING.md).

## Workflow & CI/CD

- **CI (GitHub Actions):**
    - 'CI' runs on every PR (and on pushes to `main` and `dev`): lint, typecheck, build, Prisma contract drift.
    - 'Hygiene' runs on every PR: commit convention and conflict markers.
- **Repository structure and naming rules:** see [docs/ORGANIZATION.md](docs/ORGANIZATION.md).
- **Commit convention:** see [docs/COMMIT_CONVENTION.md](docs/COMMIT_CONVENTION.md).
- **Contributing guide:** see [CONTRIBUTING.md](CONTRIBUTING.md) (setup, commit hooks, daily workflow).
- **Changelogs:** see [CHANGELOG.md](CHANGELOG.md).

## Contributors
| Github |
| - |
|[@Davheng](https://github.com/Davheng)|
|[@LectLeex](https://github.com/LectLeex)|

## License

BSD 2-Clause, see [LICENSE](LICENSE).

## Note
The README is kept small, check the corresponding section's docs
for more information.