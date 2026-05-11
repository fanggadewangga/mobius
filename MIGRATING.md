# 🚀 Migrating from Mobius v1.1 to v2.0

Mobius v2.0 introduces a modular architecture with **Core + Plugins**. While it is backward compatible with your existing agent files (CLAUDE.md, etc.), the internal directory structure of the Mobius repository has changed.

## What's Changed?
1. **Core Skills**: Principles like "Think Before Coding" are now in `core/skills/`.
2. **Platform Plugins**: Mobile skills are now in `plugins/mobile/`.
3. **Web Support**: New `plugins/web/` for React, Vue, and TanStack.
4. **Impact Indicator**: Improved `mobius diff` with better statistics and web metrics.

## How to Upgrade?
If you are already using Mobius in a project:

1. **Update your MOBIUS_HOME**: Ensure your alias points to the new `cli/mobius.sh`.
2. **No re-init needed**: Your existing `.mobius/` folder in your project will still work.
3. **Run Sync**: Run `mob sync` to ensure your agent files have the latest references (optional but recommended).

## New Commands
- `mob on`: Enable Mobius (restores agent files from backups).
- `mob off`: Disable Mobius (backups agent files to `.bak`).
- `mob diff report`: Now shows detailed percentage improvements and impact deltas.
