# agent-skills

![agent-skills: skills I use every day with Claude](docs/images/banner.png)

[![Sponsor](https://img.shields.io/badge/Sponsor-GitHub-827dbd?logo=githubsponsors&logoColor=white)](https://github.com/sponsors/mutlumehmet)
[![Buy me a coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-support-d97757?logo=buymeacoffee&logoColor=white)](https://buymeacoffee.com/mutlumehmet)
[![License: MIT](https://img.shields.io/badge/license-MIT-629987)](LICENSE)

Agent Skills I use every day with Claude, cleaned up so they work on anyone's machine.

A skill is a folder with a `SKILL.md` file: instructions, plus small scripts where needed, that Claude
loads when a task calls for it. Nothing here is tied to my setup. Anything that differs between
people lives in a config file outside the repo, and every integration beyond the basics is optional.

## Skills

| Skill | What it does |
|---|---|
| [`create-project`](skills/create-project) | Sets up a new project folder the same way every time, for code or for a folder of notes and documents |

## Install

**As a Claude Code plugin:**

```
/plugin marketplace add mutlumehmet/agent-skills
/plugin install create-project@mutlumehmet-agent-skills
```

Plugin skills are namespaced, so it runs as `/create-project:create-project`, or just ask Claude to
"create a new project".

**As a plain skill** (Claude Code, or anywhere that reads a skills folder): copy or symlink the skill
folder into your skills directory.

```bash
git clone https://github.com/mutlumehmet/agent-skills.git
ln -s "$PWD/agent-skills/skills/create-project" ~/.claude/skills/create-project
```

Then run `/create-project`, or ask Claude to "set up a new project for my house move".

---

## create-project

![create-project: asks, builds, ready](docs/images/create-project-flow.png)

I start a separate folder for everything I get AI help with: code, but also family paperwork,
accounting, a house move. This skill makes every one of them start the same way, so that a new agent
session in that folder knows where things are without being told.

### What it does

1. **Asks first.** Code, notes and documents, or both? Which language for the docs? Is there a place
   for heavy files like PDFs and scans? Local git or a private GitHub repo? What must never reach
   GitHub? The answers change the layout, so it does not guess.
2. **Builds the folder.** Runs the real scaffold for code (`uv init`, `create-next-app` and so on),
   creates topic folders for a dossier, and writes a `.gitignore` that already covers secrets and OS
   junk.
3. **Keeps heavy and sensitive files out of git.** Optionally, `assets/` is a symlink into a synced
   cloud folder (OneDrive, Google Drive, Dropbox, iCloud Drive). Files are backed up, never
   committed. `setup-assets.sh` recreates the link on a fresh clone.
4. **Writes two documents.** `CLAUDE.md` for what never changes about the project, `STATUS.md` for
   where things stand today. A new session reads `STATUS.md` first and carries on.
5. **Creates the repo safely.** Private by default. If you have more than one GitHub account logged
   in, it checks which one is active first, because `gh repo create` silently uses the active one.

### First run

The first time it runs, the skill looks for its config at `~/.config/create-project/config.yaml`.
If there is none, it detects what it can (cloud folders on your machine, `gh` accounts), asks you
for the rest, and writes the file. After that it never asks setup questions again. Edit the file any
time, or ask Claude to "reconfigure create-project".

Set `CREATE_PROJECT_CONFIG` to keep the config somewhere else.

### Configuration

Every key is optional. See [`config.example.yaml`](skills/create-project/config.example.yaml) for
a commented copy.

| Key | What it is for | Default |
|---|---|---|
| `projects_root` | Where new project folders are created | `~/Projects` |
| `languages` | Languages you write project docs in. The first is suggested | `[English]` |
| `offer_claude_language` | For non-English docs, offer to make Claude answer in that language inside that folder only (`.claude/settings.local.json`) | `true` |
| `templates_dir` | Your own `CLAUDE.<language>.md` and `STATUS.<language>.md` templates. Without it, the English templates are used (translated if needed) | empty |

### Optional integrations

You do not need any of these. Leave them empty and the skill skips the step.

| Key | Use it if | What happens |
|---|---|---|
| `storage.path`, `storage.label` | You want heavy or sensitive files in a synced cloud folder | Projects can get an `assets/` symlink into `<path>/<project>/assets`, always gitignored |
| `github.accounts`, `github.default`, `github.visibility` | You use GitHub through the `gh` CLI | Offers a repo, private unless you ask otherwise. With two or more accounts, checks the active one first. Without `gh`, local git only |
| `claude_accounts.command`, `claude_accounts.accounts` | You run more than one Claude account and have a tool that assigns folders to accounts | Asks which account, then runs your command with `{path}` and `{account}` filled in |
| `registry.file`, `registry.columns`, `registry.check_command` | You keep one markdown file listing all your projects | Adds a row for the new project, then runs your check command if set |

### What it will never do

- Create a public repository unless you explicitly ask for one.
- Merge into or overwrite a folder that already exists.
- Commit anything under `assets/`.
- Invent facts to fill a table: unknown values are written as "unknown", with where to find them.
- Change your global Claude settings. The per-project language goes in that folder's
  `.claude/settings.local.json` only.

### Requirements

macOS or Linux, `git`, and `bash`. Optional: `gh` for GitHub repos, `jq` for an extra settings check.
Windows is not supported yet (symlinks need admin rights there).

---

## Contributing

Issues and pull requests are welcome. The rules every skill follows are in [`CLAUDE.md`](CLAUDE.md):
nothing personal in the repo, everything configurable has a default, English only.

`scripts/check-personal.sh` is a pre-commit hook that refuses commits containing anything from your
own list of personal terms (kept outside the repo). Install it with:

```bash
ln -sf ../../scripts/check-personal.sh .git/hooks/pre-commit
```

## About

I'm Mehmet Mutlu, a London-based software engineer with 10+ years of building for the web, now
focused on AI. I was an early adopter of AI in day-to-day engineering and became my team's AI
advocate, building agentic workflows that were adopted by teams and professionals. Today I build
AI-native solutions for businesses with complex workflows, and AI tools for teams, engineers,
designers and professionals. This repo is where I share the pieces that proved useful day to day.

- Portfolio: [mehmetmutlu.dev](https://www.mehmetmutlu.dev)
- LinkedIn: [Mehmet Mutlu](https://www.linkedin.com/in/mehmet-mutlu-03aa7319a/)
- X: [@findmutlu](https://x.com/findmutlu)
- GitHub: [@mutlumehmet](https://github.com/mutlumehmet)

If a skill here saves you some time, you can [sponsor me on GitHub](https://github.com/sponsors/mutlumehmet) or [buy me a coffee](https://buymeacoffee.com/mutlumehmet).

## License

[MIT](LICENSE)
