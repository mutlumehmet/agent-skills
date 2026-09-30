# agent-skills

A collection of Agent Skills: folders of instructions, plus small scripts where needed, that an agent
such as Claude loads when a task calls for them. Each skill lives in its own folder under `skills/`
and is self-contained. Fixed context lives in this file, current state in `STATUS.md`.

**To see where things stand, read `STATUS.md` first.**

## Folder layout

| Path | Contents |
|---|---|
| `skills/<name>/SKILL.md` | The skill itself: YAML frontmatter (`name`, `description`) and instructions |
| `skills/<name>/...` | Anything the skill needs: scripts, templates, reference files |
| `skills/<name>/config.example.yaml` | For configurable skills: every setting, commented, with defaults |

## Rules for every skill in this repo

- **Nothing personal, ever.** No email addresses, usernames, local paths, account names, client or
  project names, tokens, or anything that only makes sense on one person's machine. A value that
  differs between users belongs in the skill's config file, which lives outside the repo
  (`~/.config/<skill>/config.yaml`) and is never committed. Examples use neutral placeholders.
- **Works with no config.** Every setting has a sensible default. Optional integrations (a second
  GitHub account, a cloud storage folder, a project registry) are skipped cleanly when not
  configured, and the README says they are optional.
- **First run sets itself up.** A configurable skill checks whether its config file exists. If not, it
  detects what it can (cloud storage folders, `gh` accounts), asks only for the rest, and writes the
  file. It never asks again unless told to reconfigure.
- **English only**, in skill text, templates, triggers and docs.
- **No em dashes, en dashes or double hyphens** in anything written. Use commas, colons, parentheses
  or a new sentence.
- **Each skill has a README section** covering what it does, how to install it, every config key
  (what it is for, required or optional, default, example), and what it will never do.
- Never commit `.env`, config files with real values, or OS junk (`.DS_Store`).

## Adding or updating a skill

1. Put it in `skills/<kebab-case-name>/` with a `SKILL.md` whose `description` says what it does and
   when to use it, with concrete trigger phrases.
2. Scan for anything personal before committing (see the rule above). A useful check:
   `grep -rniE "@|/Users/|/home/|token|secret" skills/<name>`.
3. Test it on a throwaway target before calling it done.
4. Update the README index and `STATUS.md`.
