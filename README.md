# 🔄 MOBIUS — Professional AI Skills Framework

> **"Where expertise meets AI cognition — across Mobile, Web, and Backend."**

Mobius is a **modular skills framework and context injection system** designed to align AI coding agents with professional development standards. It bridges the gap between raw LLM capabilities and your team's specific expertise, patterns, and workflows.

---

## 🚀 The Mobius Philosophy

Mobius follows a **Core + Plugins** architecture:
1. **Core Skills**: Universal cognitive principles (Think Before Coding, Simplicity First, Surgical Changes).
2. **Workflow Skills**: Structured execution phases (Brainstorm → Plan → TDD → Debug → Review).
3. **Platform Plugins**: Specific expertise for **Flutter**, **Android**, **iOS**, **Web**, and **Go Backend**.
4. **Private Contexts**: Secure, team-specific conventions stored in private submodules.

---

## 🛠 Features

- **Multi-Agent Support**: Generate unified context for Claude Code, Cursor (.mdc), GitHub Copilot, and more.
- **Smart Platform Detection**: Automatically detects project types (Flutter, Go, React, etc.) and suggest relevant plugins.
- **Financial-Grade Security**: Built-in Go security audit workflows with 15+ vulnerability patterns.
- **Private Context Strategy**: Keep internal team conventions (internal service names, folder structures) private while keeping skills public.
- **Deep Codebase Understanding**: Automated generation of Mermaid diagrams and service boundary maps.
- **Impact Tracking (`mobius diff`)**: Measure AI efficiency gains (fewer rework iterations, higher build success).

---

## 📂 Project Structure

```bash
├── cli/              # Mobius CLI (the 'mobius' command)
├── core/             # Universal cognitive and workflow skills
├── plugins/          # Platform-specific expertise
│   ├── mobile/       # Flutter, Android, iOS skills
│   ├── web/          # React, Vue, TanStack skills
│   └── backend/      # Go Microservice skills
├── templates/        # Base context templates per platform
└── contexts/         # (Optional) Private submodules for team context
```

---

## 🏗️ Getting Started

### 1. Installation
Add an alias to your `~/.zshrc` or `~/.bashrc`:
```bash
alias mobius='/path/to/mobius/cli/mobius.sh'
```

### 2. Initialize a Project
Navigate to your project directory and run:
```bash
mobius init
```
This will:
1. Detect your platform (e.g., Flutter or Go).
2. Ask specific configuration questions (Architecture, DI, etc.).
3. Detect if private contexts are available.
4. Create a `.mobius/` folder with tailored instructions for your AI agent.

### 3. Setup Private Contexts (Optional)
To use internal team conventions without exposing them in public repositories:
```bash
mobius context add-private [your-private-git-url]
```
This adds a private submodule to `contexts/private/`. Ensure your `.gitignore` excludes this directory from the public Mobius repo.

---

## 📖 Using Mobius

### Skill Execution
Skills are triggered by specific keywords in your chat with the AI.
- **Flutter**: "change splash screen", "add new route", "fix sizing"
- **Go**: "security audit", "pahami codebase", "refactor concurrency"
- **Web**: "create page", "setup tanstack query"

### Context Syncing
Whenever you change `.mobius` configurations or update Mobius skills, run:
```bash
mobius sync
```
This ensures all agent-specific files (like `CLAUDE.md` or `.cursor/rules/`) are up to date.

### 4. Working with AI Agents
Once initialized, your AI agent (Claude Code, Cursor, Windsurf, etc.) will read the `.mobius/` context. 
- **Instruction**: Tell your agent: *"Read the Mobius context in .mobius/ and use the skills from my Mobius Home directory."*
- **Auto-Loading**: Agents like Cursor will automatically detect `.cursor/rules/mobius.mdc`.
- **Keywords**: Use the triggers defined in the plugins (e.g., "pahami codebase", "audit security") to activate specific workflows.

---

## 🛠️ Management Commands

| Command | Description |
|---|---|
| `mobius skill list` | Browse all available expertise |
| `mobius skill create` | Wizard to codify a new pattern into a skill |
| `mobius docs generate` | Generate deep-dive docs with Mermaid diagrams |
| `mobius audit run` | Run a financial security audit on a service |
| `mobius review run` | Run a performance and reliability review |
| `mobius doctor` | Check the health of your Mobius installation |

---

## ✍️ Adding New Skills

Mobius is designed to be expanded. To add a new skill:
1. Create a directory in `plugins/[category]/[platform]/[skill-name]/`.
2. Add a `SKILL.md` file with the following frontmatter:
```yaml
---
name: your-skill-name
trigger: "keyword1", "keyword2"
platform: mobile/flutter # or backend/go, etc.
---
# Skill Content
...
```
3. Update the `plugin.md` manifest in the parent directory.

---

## 📄 License

MIT — Feel free to use, fork, and adapt it to your own professional workflow.
