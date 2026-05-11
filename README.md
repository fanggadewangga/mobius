# 🔄 MOBIUS — Professional AI Skills Framework

> **"Where expertise meets AI cognition — across Mobile, Web, and Beyond."**

Mobius is a **modular skills framework and context injection system** designed to align AI coding agents with professional development standards. It bridges the gap between raw LLM capabilities and your team's specific expertise, patterns, and workflows.

This repository is a collection of **workflows and skills** that I use daily in my professional work and personal projects. It's designed to be a portable, zero-dependency "brain" for AI agents.

---

## 🚀 The Mobius Philosophy

Mobius follows a **Core + Plugins** architecture:
1. **Core Skills**: Universal cognitive principles (Think Before Coding, Simplicity First, Surgical Changes).
2. **Workflow Skills**: Structured execution phases (Brainstorm → Plan → TDD → Debug → Review).
3. **Platform Plugins**: Specific expertise for **Flutter**, **Android**, **iOS**, and modern **Web** (React, Next.js, Vue, TanStack).

---

## 🛠 Features

- **Multi-Agent Support**: Generate unified context for Claude Code, Cursor (.mdc), GitHub Copilot, Windsurf, and more.
- **Smart Platform Detection**: Automatically detects project types (Flutter, Android, React, etc.) and suggests relevant plugins.
- **Team-Specific Safeguards**: Enforce conventions like `auto_route` patterns, `SizesApp` constants, and `no-hardcoded-strings`.
- **Modular Plugin System**: Add or remove platform-specific expertise without bloating your project context.
- **Impact Tracking (`mob diff`)**: Built-in statistical reporting to measure how much Mobius improves AI efficiency (fewer rework iterations, higher build success).
- **Interactive Skill Creation**: Wizard-based workflow to capture and codify new patterns as you find them.

---

## 📂 Project Structure

```bash
├── cli/              # Mobius CLI (the 'mob' command)
├── core/             # Universal cognitive and workflow skills
├── plugins/          # Platform-specific expertise
│   ├── mobile/       # Flutter, Android, iOS skills
│   └── web/          # React, Vue, TanStack, TypeScript skills
├── templates/        # Base context templates per platform
└── MOBIUS_CATALOG.md # (Ignored) Full command documentation
```

---

## 🌟 Inspiration & Credits

Mobius is built on the shoulders of giants. This framework wouldn't be possible without the influence of:

- **[Superpowers](https://github.com/superpowers-ai/superpowers)**: For the foundational "Goal-Driven Execution" and the structured agentic workflow (Brainstorm → Plan → Execute → Review) that forms the core of Mobius.
- **[Andrej Karpathy](https://github.com/karpathy)**: For inspiring the cognitive "Karpathy Skills" (Think Before Coding, Simplicity First, Surgical Changes) and the vision of an LLM-centric developer workflow.

---

## 🏗️ Usage

### 1. Installation
Add an alias to your `~/.zshrc` or `~/.bashrc`:
```bash
alias mob='/path/to/mobius/cli/mobius.sh'
```

### 2. Initialize a Project
```bash
mob init
```
This will detect your platform and create a `.mobius/` folder with tailored project instructions.

### 3. Management
- `mob on/off`: Quickly toggle Mobius instructions.
- `mob sync`: Distribute context updates to all agent files (CLAUDE.md, etc.).
- `mob skill list`: Browse available expertise.
- `mob skill create`: Codify a new pattern into a reusable skill.

### 4. Impact Measurement
```bash
mob diff baseline   # Record stats before using Mobius
mob diff record     # Record stats after a task with Mobius
mob diff report     # See the delta and efficiency gain
```

---

## 📄 License

MIT — Feel free to use, fork, and adapt it to your own professional workflow.
