# Workspace Demo

A demonstration repository for workspace management architecture and AI agent coordination.

## 🚀 Get Started

**👉 [See DEMO.md for complete setup instructions and walkthrough](./DEMO.md)**

New to this project? Start with the demo guide which includes:
- Step-by-step setup instructions
- Configuration requirements  
- Usage examples and scenarios
- Architecture explanations

## Quick Start

1. **Configure credentials**: Edit `workspace-config.json` and update your GitHub/GitLab usernames
2. **Run setup**: `./scripts/setup.sh` to validate your configuration
3. **Prime workspace**: Use Claude Code `/workspace:prime` or follow manual setup
4. **Explore**: See the complete walkthrough in [DEMO.md](./DEMO.md)

## Purpose

This repository serves as a practical example for discussions around:

- **Multi-project development workflows**
- **AI agent activity tracking and coordination** 
- **Workspace management architecture patterns**
- **File-based vs database-backed coordination systems**

## Architecture Overview

This demo is part of a larger workspace management system that includes:

```
workspace/
├── workspace-config.json     # Project definitions and user settings
├── workspace-activity.json   # AI agent activity tracking
├── projects/                 # All development projects (including this one)
│   ├── uhc-clusters-service/
│   ├── ocm-cli/
│   ├── access-transparency-service/
│   └── workspace-demo/      # This repository
├── notes/                   # Cross-project documentation
├── tasks/                   # Coordinated task management
└── scripts/                 # Automation and tooling
```

## Features Demonstrated

### 1. **Unified Project Management**
- Single configuration file manages 13+ repositories
- Cross-platform support (GitHub + GitLab)
- Automated remote configuration and branch management

### 2. **AI Agent Activity Tracking**
- Real-time task coordination between multiple AI agents
- Complete audit trail of development activities
- Context preservation across sessions

### 3. **Monodirectory Benefits**
- All projects accessible in single workspace
- Unified search across entire codebase
- Shared tooling and automation scripts



## Getting Started

This repository is designed to be part of a larger workspace. To see it in action:

1. **First time?** → [Read DEMO.md](./DEMO.md) for complete setup guide
2. **Quick setup** → Edit `workspace-config.json` with your usernames  
3. **Validate** → Run `./scripts/setup.sh`
4. **Prime workspace** → Use Claude Code `/workspace:prime`
5. **Explore** → Check activity logs and cross-project workflows

**📖 For detailed instructions, examples, and troubleshooting → [DEMO.md](./DEMO.md)**

## License

MIT License - Feel free to use these patterns in your own workspace management systems.