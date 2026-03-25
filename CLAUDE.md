# CLAUDE.md

## Project

`claude-context` is a shared repo for configuring Claude across all environments (Chat, Cowork, Code). Team members clone it, add their personal config in a gitignored `private/` directory, and run the sync script to propagate everything.

## Repository structure

| Path | Purpose |
|------|---------|
| `shared/` | Team-shared config (voice, coding prefs) -- committed |
| `private/` | Personal config (identity, secrets) -- gitignored |
| `templates/` | Example files copied to `private/` and `.env` on setup |
| `.env` | Local path config (COWORK_DIR, SKILLS_DIR) -- gitignored |
| `setup.sh` | One-time setup: creates `private/` and `.env` from templates |
| `sync-claude-context.sh` | Syncs shared + private files to Cowork, Code, and skills |

## Commands

```bash
./setup.sh                                        # First-time setup
./sync-claude-context.sh                          # Sync to Cowork + Code + skills
COWORK_DIR=~/other ./sync-claude-context.sh       # Sync with custom Cowork folder
```

## Rules

- NEVER commit files inside `private/` or `.env` -- they are gitignored for a reason
- No em dashes in any file
- Keep files concise. Claude Code's CLAUDE.md effectiveness drops past ~400 lines total.
- After editing any context file, run the sync script
