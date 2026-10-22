# Repository organization

## Summary

This file explains how the repository
is structured.

## Layout

```

```

**Important**:


As we work with a fullstack framework, we need to ensure that at least a few dispositions are taken.
Server related code is always in `src/libs/` and client ones are always in
`src/components`. As for routes, APIs are always in `src/app/api/` and
the rest (client) can be anything (except api/) inside the app router.

Create subfolders only when you need them. Ex:
- 'libs/very_cool_features/'
- 'components/very_cool_features/'

## Naming convention

- **Folders**: `lower_snake_case` and plural only e.g. `libs` not `lib`.
- **Scripts (sh) and Variables:** `lower_snake_case`.
- **Files, lib functions & useHooks:** `camelCase`.
- **Classes, TS types/interfaces, React Nodes/components:** `PascalCase`.
- **Constants:** `UPPER_SNAKE_CASE`.

## File extensions

- **Components and hooks** are always in a `.tsx`
- **Libs (server code by extension)** are always in a `.ts`