# agent-skills: current state

Last updated: **30 September 2026**. First skill, `create-project`, written, tested in three
scenarios (no config, full config, minimal config) and in daily use. Not public yet.

## At a glance

| Item | State |
|---|---|
| Repository | Private on GitHub for now, to be made public once the first skill is reviewed |
| License | MIT, added |
| README | Written: index, install, config reference, optional integrations |
| `create-project` | Written and tested: configurable storage, GitHub accounts, languages, optional account tool and registry |
| Personal-content check | `scripts/check-personal.sh`, installed as a pre-commit hook |
| Plugin marketplace manifest | Added, passes `claude plugin validate` |

## Next actions

1. Author review.
2. Make the repository public.
3. After it is public, test the install commands from the README on a clean setup.

## Decision log

- **30 September 2026:** One collection repository for all skills rather than one repository per
  skill, following the common pattern (Anthropic's and Vercel's skill collections). Installing once
  brings every skill, and larger standalone tools get their own repositories.
- **30 September 2026:** MIT license. English only. Per-user values live in a config file outside the
  repo, so the published skill and its author's own copy share the same code.
