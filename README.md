# claude-context

Shared context files that configure Claude across all environments (Chat, Cowork, Code) for the Dwarves team.

## How it works

```
claude-context/
  shared/        (committed, team-shared config)
  private/       (gitignored, your personal config)
      |
      |-- symlinks --> ~/CoworkSpace/     (Cowork reads .md at session start)
      |-- concat  --> ~/.claude/CLAUDE.md (Claude Code reads at session start)
      |-- manual  --> claude.ai memory    (update memory edits when content changes)
```

## Setup

```bash
git clone git@github.com:dwarvesf/claude-context.git ~/claude-context
cd ~/claude-context
./setup.sh
```

This creates `private/` with template files. Edit them with your details:

- `private/about-me.md` -- your role, responsibilities, working style
- `private/notion-reference.md` -- your Notion database IDs

Then sync:

```bash
./sync-claude-context.sh
```

## Sync after editing

```bash
cd ~/claude-context
# edit files in shared/ or private/...
./sync-claude-context.sh
```

For shared config changes, commit and push:

```bash
git add -A && git commit -m "update shared config" && git push
```

## Files

| Directory | File | Purpose | Committed? |
|-----------|------|---------|------------|
| `shared/` | `voice-and-style.md` | Writing tone, formatting rules | Yes |
| `shared/` | `claude-code-extras.md` | Coding prefs, CLIMB framework | Yes |
| `private/` | `about-me.md` | Your role, tools, priorities | No |
| `private/` | `notion-reference.md` | Your Notion DB IDs | No |
| `templates/` | `*.example` | Starter templates for private files | Yes |

## Security

The `private/` directory is gitignored. It may contain Notion database IDs, personal details, or other sensitive information. Never commit its contents. If you see private files in `git status`, something is wrong with your `.gitignore`.
