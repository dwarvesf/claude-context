# claude-context

Shared context files that configure Claude across all environments (Chat, Cowork, Code) for the Dwarves team.

## Why

Every team member uses Claude differently, but we want consistent behavior: same writing tone, same coding style, same prompt patterns. Without a shared config, each person maintains their own instructions, and things drift.

This repo is the single source of truth. Clone it, add your personal details, run sync. Claude behaves consistently whether you're in Code, Cowork, or Chat.

## Architecture

```
                        +-----------------------+
                        |    claude-context/     |
                        |                       |
                        |  shared/   (team)     |
                        |  private/  (you)      |
                        +-----------+-----------+
                                    |
                          sync-claude-context.sh
                                    |
                  +-----------------+-----------------+
                  |                 |                 |
                  v                 v                 v
         +--------+------+  +------+-------+  +------+------+
         |    Cowork     |  |  Claude Code |  |  Claude.ai  |
         |  (symlinks)   |  | (~/.claude/) |  |  (manual)   |
         +---------------+  +--------------+  +-------------+

                        +-----------------------+
                        |    claude-skills/      |
                        |  (separate repo)       |
                        |                       |
                        |  prompt-improver/     |
                        |  vibe-learn/          |
                        +-----------+-----------+
                                    |
                          SKILLS_DIR in .env
                                    |
                                    v
                           ~/.claude/skills/
                           (symlinked on sync)
```

## Setup

```bash
git clone git@github.com:dwarvesf/claude-context.git ~/claude-context
cd ~/claude-context
./setup.sh
```

This creates:
- `private/` with template files for your personal config
- `.env` for local path configuration

Edit your personal files:
- `private/about-me.md` -- your role, responsibilities, working style
- `private/notion-reference.md` -- your Notion database IDs
- `.env` -- set custom Cowork directory or skills repo path

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
| root | `.env` | Local path config (COWORK_DIR, SKILLS_DIR) | No |

## Skills

Skills live in a separate repo (e.g., `dwarvesf/claude-skills`). To sync them:

1. Clone your skills repo
2. Set `SKILLS_DIR=~/claude-skills` in `.env`
3. Run `./sync-claude-context.sh` -- skills are symlinked to `~/.claude/skills/`

Each skill is a folder with a `SKILL.md` file. Claude Code picks them up automatically.

For Claude.ai Chat/Web, upload skills via Claude Desktop Settings or paste SKILL.md content as project instructions.

## Security

The `private/` directory and `.env` are gitignored. Never commit their contents. If you see private files in `git status`, something is wrong with your `.gitignore`.
