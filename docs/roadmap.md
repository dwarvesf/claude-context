# Roadmap

## Process history

### Phase 1: Initial design (2026-03-25, web session)
- Researched Claude Cowork, Code, Chat configuration mechanisms
- Designed three-repo architecture split by audience and sensitivity
- Built context files (about-me, voice-and-style, notion-reference)
- Built sync script with Cowork symlinks + Code CLAUDE.md concatenation

### Phase 2: Restructure for public sharing (2026-03-25, Claude Code session)
- Separated sensitive/personal files from shareable team config
- Created shared/ (committed) and private/ (gitignored) split
- Added templates/ with .example files for team onboarding
- Created setup.sh for one-time user setup
- Rewrote sync script to use SCRIPT_DIR and handle shared + private
- Pushed to dwarvesf/claude-context as public repo

### Phase 3: Config and skills improvements (2026-03-25, same session)
- Added .env config file for persistent COWORK_DIR and SKILLS_DIR
- Added motivation section and architecture diagram to README
- Added skills syncing from external repo via SKILLS_DIR variable
- Scaffolded dwarvesf/claude-skills as plugin repo with prompt-improver skill
- Extracted prompt improvement from claude-code-extras.md into SKILL.md

### Phase 4: Content rules and sync improvements (2026-03-25, Claude Code session)
- Added shared/knowledge-capture.md and shared/content-spec-rule.md
- Added templates for instructions.md and knowledge-capture-config.md
- Updated README with complete file table and sync flow diagram
- Rewrote sync script step 3: marker-based CLAUDE.md merge instead of full overwrite
- Added H2 dedup: skips sections the user already has in their own CLAUDE.md
- Added migration path from old full-overwrite format

## Done

- [x] Restructure claude-context for public sharing
- [x] Push to dwarvesf/claude-context
- [x] .env support for COWORK_DIR and SKILLS_DIR
- [x] README with motivation and architecture diagram
- [x] Skills sync step in sync script
- [x] Scaffold dwarvesf/claude-skills with plugin manifest
- [x] prompt-improver skill
- [x] Architecture docs
- [x] Knowledge capture and content spec rules (shared)
- [x] Marker-based CLAUDE.md merge (preserves user config)
- [x] H2 dedup (skip sections user already has)

## Next

- [ ] **Capture skill**: A `/capture` skill in claude-skills that helps format and save content from Claude.ai web sessions into the right place (skill, config, or memory)
- [ ] **Test plugin install**: Run `/plugin marketplace add dwarvesf/claude-skills` to verify the marketplace flow
- [ ] **Scaffold dwarves-ops-skills**: Private repo for team-specific workflow skills that reference Notion DB IDs
- [ ] **More skills**: Extract CLIMB framework as a skill, migrate vibe-learn from local to claude-skills
- [ ] **Team onboarding**: Have a team member go through the full setup flow and capture friction points
