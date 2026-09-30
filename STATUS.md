# agent-skills: current state

Last updated: **30 September 2026**. First skill, `create-project`, written, tested in three
scenarios (no config, full config, minimal config) and in daily use. Public since 30 September 2026.

## At a glance

| Item | State |
|---|---|
| Repository | Public, with social preview image, description and topics |
| Funding | GitHub Sponsors and Buy Me a Coffee (`.github/FUNDING.yml`) |
| License | MIT, added |
| README | Written: index, install, config reference, optional integrations |
| `create-project` | Written and tested: configurable storage, GitHub accounts, languages, optional account tool and registry |
| Personal-content check | `scripts/check-personal.sh`, installed as a pre-commit hook |
| Plugin marketplace manifest | Added, passes `claude plugin validate` |

## Next actions

1. Add the next skill.

## Decision log

- **30 September 2026:** One collection repository for all skills rather than one repository per
  skill, following the common pattern (Anthropic's and Vercel's skill collections). Installing once
  brings every skill, and larger standalone tools get their own repositories.
- **30 September 2026:** MIT license. English only. Per-user values live in a config file outside the
  repo, so the published skill and its author's own copy share the same code.
- **30 September 2026:** Made public. Install commands from the README tested on a clean setup:
  marketplace add, plugin install, and a plain clone all work.
