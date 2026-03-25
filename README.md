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

## Sync flow

What `sync-claude-context.sh` does, step by step:

```
  .env (COWORK_DIR, SKILLS_DIR)
       |
       v
  [1] Cowork: symlink shared/*.md + private/*.md --> ~/CoworkSpace/
       |
  [2] Skills: symlink SKILLS_DIR/*/SKILL.md --> ~/.claude/skills/
       |
  [3] Code:   merge shared/*.md + private/*.md --> ~/.claude/CLAUDE.md
       |       (marker-based: preserves user's own content, dedup by H2)
       |
  [4] Chat:   print reminder (manual step, no API)
```

Each target gets the same content through different mechanisms: Cowork uses live symlinks (edits propagate instantly), Code merges into `~/.claude/CLAUDE.md` between `BEGIN/END` markers (preserving any existing user config and skipping duplicate sections), and Chat requires manual copy.

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
| `shared/` | `knowledge-capture.md` | Auto-detect learning moments, classify and clean | Yes |
| `shared/` | `content-spec-rule.md` | Require spec approval before long content | Yes |
| `private/` | `about-me.md` | Your role, tools, priorities | No |
| `private/` | `instructions.md` | Personal behavioral rules, prompt improvement | No |
| `private/` | `notion-reference.md` | Your Notion DB IDs | No |
| `private/` | `knowledge-capture-config.md` | Push destination (Capacities, Obsidian, etc.) | No |
| `templates/` | `*.example` | Starter templates for private files | Yes |
| root | `.env` | Local path config (COWORK_DIR, SKILLS_DIR) | No |

## Skills

Skills live in a separate repo: [dwarvesf/claude-skills](https://github.com/dwarvesf/claude-skills).

### Option 1: Plugin marketplace (recommended)
```bash
/plugin marketplace add dwarvesf/claude-skills
/plugin install claude-skills@dwarvesf-claude-skills
```

### Option 2: Local clone with sync
```bash
git clone git@github.com:dwarvesf/claude-skills.git ~/claude-skills
# In .env: SKILLS_DIR=~/claude-skills/skills
./sync-claude-context.sh
```

For Claude.ai Chat/Web, upload skills via Claude Desktop Settings or paste SKILL.md content as project instructions.

## Security

The `private/` directory and `.env` are gitignored. Never commit their contents. If you see private files in `git status`, something is wrong with your `.gitignore`.
