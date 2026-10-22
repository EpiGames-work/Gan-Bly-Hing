# Commit Convention

Conventional Commits, Redux version : a smaller set of types and a few extra ones for merges, rebases and pull requests.

## Format

```
[type]: {optional scope}: **C**ontent
```

- `type` is always required.
- The scope is optional and gives extra context (a module, a sub-branch, a ticket...).
- `Content` is a short description of the change. Is also always capitalized

## Regular types

| Type | Usage | Example |
| - | - | - |
| `feat` | Feature | `feat: auth: Add password reset flow` |
| `fix` | Fix | `fix: Handle null user in profile page` |
| `style` | Styling | `style: Reformat 'src/lib/MyHook.tsx'` |
| `chore` | Docs and miscellaneous | `chore: Updated README.md` |
| `devops` | CI/CD, tooling, unit tests... | `devops: ci: Cache dependencies` |

## Merge

Always prefix a merge with `mg`, such as : <br>
(usually when merging inner branches or `git pull` with `--rebase`) <br>

```
mg: Merge tracking branch 'origin/feat/login' into feat/login`
```

## Revert

Same as the merge but with `revert` as prefix, such as <br>

```
revert: Revert ...
```

## Rebase

Prefix the regular commit with `rebase`:

[Syntax]
```
rebase: [type]: ...
```

[Example]
```
rebase: fix: Handle null user in profile page
```

## Pull requests

### Review level

Add `minor` or `major` right after the type:

| Syntax | Usage | Example |
| - | - | - |
| `[type]: minor: ...` | No review needed. E.g. merging sub-branches of a bigger branch that is not `main` or `dev`. | `feat: minor: Merge sub-branch feat/login-form into feat/login` |
| `[type]: major: ...` | Review mandatory. E.g. `main`, `dev`, or any branch with multiple contributors. | `fix: major: Merge fix/session-expiry into dev` |

### `pr` type

`pr` is used for pull request merges: `Merge tracking branch...`. <br>
It never describes the content directly, always a type. <br>

```
pr: Merge tracking branch 'origin/feat/login' into dev
```

## Note

If your latest commit is poorly formatted,
you can possibly use :

```
git commit --amend -m "[type]: {scope}: Content"
git push --force-with-lease
```

Otherwise, try not to make too many commit mistakes.