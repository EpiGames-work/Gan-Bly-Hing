# Repository organization

## Summary

This file explains how the repository
is structured.

## Layout

```
.
├── .github/
│   ├── workflows/          # ci.yml (lint, typecheck, build, contract), hygiene.yml
│   ├── ISSUE_TEMPLATE/     # bug report, feature request
│   ├── CODEOWNERS
│   └── pull_request_template.md
├── docs/                   # project documentation
│   ├── COMMIT_CONVENTION.md
│   ├── ORGANIZATION.md
│   └── TECHNOLOGIES.md
├── scripts/                # git hook helpers (commit message check / rewrite)
├── src/                    # the Next.js application (run every pnpm command from here)
│   ├── app/                # App Router: pages, layout, globals.css (APIs go in app/api/)
│   ├── components/         # client code (ui/ for shared building blocks)
│   ├── libs/               # server code
│   ├── prisma/
│   │   ├── contract.prisma # data contract (source of truth)
│   │   ├── contract.json   # generated, committed
│   │   ├── contract.d.ts   # generated, committed
│   │   ├── db.ts           # database client
│   │   └── migrations/     # app/ (migrations) and snapshots/
│   ├── public/             # static assets
│   ├── prisma.config.ts    # Prisma CLI configuration
│   ├── biome.json
│   └── package.json
├── docker-compose.yml      # local PostgreSQL
├── lefthook.yml            # git hooks
├── CHANGELOG.md
├── CONTRIBUTING.md
└── README.md
```

**Important**:


As we work with a fullstack framework, we need to ensure that at least a few dispositions are taken.
Server related code is always in `src/libs/` and client ones are always in
`src/components`. As for routes, APIs are always in `src/app/api/` and
the rest (client) can be anything (except api/) inside the app router.

Create subfolders only when you need them. Ex:
- 'libs/very_cool_features/'
- 'components/very_cool_features/'

Files in `src/prisma/` named `contract.json` and `contract.d.ts` are generated:
never edit them by hand, run `pnpm contract:emit` instead.

## Naming convention

- **Folders**: `lower_snake_case` and plural only e.g. `libs` not `lib`.
- **Scripts (sh) and Variables:** `lower_snake_case`.
- **Files, lib functions & useHooks:** `camelCase`.
- **Classes, TS types/interfaces, React Nodes/components:** `PascalCase`.
- **Constants:** `UPPER_SNAKE_CASE`.

## File extensions

- **Components and hooks** are always in a `.tsx`
- **Libs (server code by extension)** are always in a `.ts`
