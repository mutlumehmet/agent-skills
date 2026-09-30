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
| `skills/<name>/README.md` | The skill's own page: what it does, settings, install |
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
- **Each skill has its own `skills/<name>/README.md`** covering what it does (with a visual if it
  helps), first run, every config key (what it is for, required or optional, default, example),
  optional integrations, what it will never do, requirements and its exact install commands. GitHub
  shows it when someone opens the folder.
- **The main `README.md` stays short:** banner, intro, one table row per skill (name linking to its
  folder, one-line description), generic install, contributing, about, license. Skill details never
  go into the main README.
- Never commit `.env`, config files with real values, or OS junk (`.DS_Store`).

## Adding or updating a skill

1. Put it in `skills/<kebab-case-name>/` with a `SKILL.md` whose `description` says what it does and
   when to use it, with concrete trigger phrases.
2. Scan for anything personal before committing (see the rule above). A useful check:
   `grep -rniE "@|/Users/|/home/|token|secret" skills/<name>`.
3. Test it on a throwaway target before calling it done.
4. Write `skills/<name>/README.md`, add the skill's row to the main README table, add it to
   `.claude-plugin/marketplace.json`, update the banner's skill chips if they list skills, and update
   `STATUS.md`.
