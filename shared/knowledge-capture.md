# Knowledge capture rules

## Auto-detect learning moments

During coding or discussion sessions, watch for these patterns that indicate
a learning moment worth capturing:

1. **Root cause explanation**: You just explained WHY something broke, not just how to fix it
2. **Architectural decision**: You just made a non-obvious choice between alternatives and explained the tradeoff
3. **Concept breakthrough**: You just broke a debugging spiral by explaining an underlying concept the user was missing
4. **Pattern recognition**: You identified a recurring pattern or anti-pattern worth documenting

When you detect one of these, suggest capturing it:
"That explanation about [topic] seems worth capturing. Want me to save it?"

Never auto-push without user confirmation.

## Capture format

Classify each learning note into one type:

| Signal | Type | Description |
|--------|------|-------------|
| Clear question + answer | Definition | Q&A format, "what is X", comparison |
| Short single concept, < 500 words | Atomic note | TIL, gotcha, tip |
| Multi-section, long explanation | Page | Tutorial, walkthrough |

## Clean content before saving

Strip all conversational artifacts:
- Openers: "Sure, here's...", "Great question!"
- Closers: "Let me know if...", "Want me to..."
- Meta-commentary about the conversation
- Prompt improvement sections

The note should read as a standalone reference, not a chat transcript.

## Accumulate mode (Claude Code)

During coding sessions, silently log learning moments to `./learned-today.md`:
- Append each entry with a YAML frontmatter block (title, type, date, tags)
- Separate entries with `---`
- Do NOT push to any external service automatically
- User runs `/learned` to cherry-pick or `/push-learned` to batch push

## Push destination

The push target depends on the user's personal config.
Read the push destination and method from the user's private instructions file.
If no push config exists, save to `~/knowledge/learned-today.md` as fallback.
