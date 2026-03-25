# Architecture

## Overview

`claude-context` is a shared repo for syncing Claude configuration across all environments (Code, Cowork, Chat/Web) for the Dwarves team.

## Three-repo architecture

Split by audience and sensitivity, not by file type.

| Repo | Visibility | Purpose |
|------|-----------|---------|
| `dwarvesf/claude-context` | Public | Config and identity (this repo) |
| `dwarvesf/claude-skills` | Public | Reusable skills with SKILL.md format |
| `dwarves-ops-skills` | Private (planned) | Team-specific workflow skills referencing Notion DB IDs |

**Why three repos:** Skills have their own lifecycle (versioning, testing, marketplace distribution). Config is stable identity; skills are evolving behaviors. Ops skills reference sensitive DB IDs and must stay private.

## Directory structure

```
claude-context/
  shared/              # Committed. Team-shared config.
    voice-and-style.md
    claude-code-extras.md
    knowledge-capture.md
    content-spec-rule.md
  private/             # Gitignored. Per-user personal config.
    about-me.md
    instructions.md
    notion-reference.md
    knowledge-capture-config.md
  templates/           # Committed. Copied to private/ on setup.
    about-me.md.example
    instructions.md.example
    notion-reference.md.example
    knowledge-capture-config.md.example
    env.example
  docs/                # Committed. Architecture and roadmap.
  .env                 # Gitignored. Local path config.
  setup.sh             # One-time setup.
  sync-claude-context.sh  # Syncs to all targets.
```

## Sync targets

```
                    +-----------------------+
                    |    claude-context/     |
                    |  shared/   private/   |
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
                    +-----------+-----------+
                                |
                      SKILLS_DIR in .env
                                |
                                v
                       ~/.claude/skills/
                       (symlinked on sync)
```

| Target | Mechanism | What syncs |
|--------|-----------|------------|
| Claude Code | Concatenated `~/.claude/CLAUDE.md` | shared/ + private/ files |
| Claude Code | Symlinks to `~/.claude/skills/` | Skills from SKILLS_DIR |
| Cowork | Symlinks to `~/CoworkSpace/` | shared/ + private/ files |
| Claude Chat/Web | Manual memory edits | User copies content manually |

## Key decisions

### 1. shared/ + private/ in same repo (not separate repos)

One clone, one sync, one mental model. Gitignored `private/` is simpler than cross-repo references. Same pattern as `.env.example`.

### 2. Symlinks for Cowork, concatenation for Code

Cowork reads `.md` files from working directory, so symlinks give live updates. Code reads a single `~/.claude/CLAUDE.md`, so concatenation is required.

### 3. Skills via external SKILLS_DIR (not embedded in this repo)

Skills belong in separate repos. This repo is config/identity only. The sync script optionally symlinks skills from `SKILLS_DIR` into `~/.claude/skills/`.

Two install methods for skills:
- **Plugin marketplace:** `/plugin marketplace add dwarvesf/claude-skills`
- **Local symlinks:** Set `SKILLS_DIR` in `.env`, run sync

### 4. .env for persistent configuration

Environment variables work but aren't persistent. A `.env` file (gitignored) lets users set `COWORK_DIR` and `SKILLS_DIR` once.

### 5. Claude Chat/Web sync is manual

Claude.ai uses server-side memory with no export API. No automation possible. The sync script prints a reminder. Users can paste SKILL.md content as project instructions or use Claude Desktop Settings.

## Security boundaries

| Content | Location | Committed? |
|---------|----------|------------|
| Notion DB IDs | `private/notion-reference.md` | No (gitignored) |
| Personal identity | `private/about-me.md` | No (gitignored) |
| Team config | `shared/` | Yes |
| Local paths | `.env` | No (gitignored) |
