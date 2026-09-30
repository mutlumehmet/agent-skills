# agent-skills: current state

Last updated: **30 September 2026**. Repository created. No skills published yet; the first one,
`create-project`, is being prepared.

## At a glance

| Item | State |
|---|---|
| Repository | Private on GitHub for now, to be made public once the first skill is reviewed |
| License | MIT, **not added yet** |
| README | **Not written yet** |
| `create-project` | In preparation: making it configurable (storage, GitHub accounts, languages, optional registry) |
| Plugin marketplace manifest | **Not added yet** (`.claude-plugin/marketplace.json`) |

## Next actions

1. Add `skills/create-project/` with its `config.example.yaml`, first-run setup and English templates.
2. Test it on a throwaway project, with and without a config file.
3. Write the README (index, install, config reference) and add the MIT `LICENSE`.
4. Add the marketplace manifest so it can be installed with `/plugin marketplace add`.
5. Review, then make the repository public.

## Decision log

- **30 September 2026:** One collection repository for all skills rather than one repository per
  skill, following the common pattern (Anthropic's and Vercel's skill collections). Installing once
  brings every skill, and larger standalone tools get their own repositories.
- **30 September 2026:** MIT license. English only. Per-user values live in a config file outside the
  repo, so the published skill and its author's own copy share the same code.
