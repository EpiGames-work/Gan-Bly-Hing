# Contributing

## Summary

Short version of how we work. <br>
Details on folders and naming: ['docs/ORGANIZATION.md'] <br>

## One-time setup

tba

## Daily workflow

tba

## Commit convention

We follow a custom version of GitHub's conventional commit,
it is described in the ['docs/COMMIT_CONVENTION.md']

## Changelogs

Remember to update the changelogs, see ['CHANGELOG.md'], on each meaningful merge into the `main` branch.

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

tba

## Reporting bugs and tasks

Use the issue template (Issues -> New issue).