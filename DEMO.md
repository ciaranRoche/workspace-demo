# Workspace Management System Demo

Welcome! This repository demonstrates a sophisticated AI agent workspace management system that coordinates multiple development projects, tracks activities, and enables seamless cross-project workflows.

## 🚀 Quick Start

### Step 1: Configure Your Credentials

**IMPORTANT**: Before using this workspace, update your GitHub and GitLab usernames in the configuration.

Edit `workspace-config.json`:

```json
{
  "user": {
    "github_username": "YOUR_GITHUB_USERNAME",
    "gitlab_username": "YOUR_GITLAB_USERNAME" 
  }
}
```

Replace:
- `"YOUR_GITHUB_USERNAME"` with your actual GitHub username
- `"YOUR_GITLAB_USERNAME"` with your actual GitLab username (or GitHub username if you don't use GitLab)

### Step 2: Install Prerequisites

Ensure you have:
- **Git** with SSH keys configured for GitHub
- **Claude Code** installed and configured
- **jq** for JSON processing (optional but recommended)

### Step 3: Prime the Workspace

Run the workspace priming command to set up all projects:

```bash
# Using Claude Code
claude-code /workspace:prime

# Or manually (if Claude Code not available)
./scripts/manual-setup.sh
```

This will:
- Create `projects/` directory
- Clone `rh-trex` and `ocm-cli` repositories  
- Configure git remotes with your fork URLs
- Set up proper branches
- Update activity tracking

## 📁 What Gets Created

After priming, your workspace will look like:

```
workspace-demo/
├── workspace-config.json          # Project definitions (YOU EDITED THIS)
├── workspace-activity.json        # AI agent activity tracking
├── .claude/                       # Claude Code configuration
│   ├── bootstrap.md               # Initialization instructions  
│   ├── config.md                  # Global settings
│   └── commands/                  # Available commands
├── projects/                      # YOUR DEVELOPMENT PROJECTS
│   ├── rh-trex/                   # Cloned from GitHub
│   │   ├── .git -> origin (upstream)
│   │   └── .git -> YOUR_USERNAME (fork)
│   └── ocm-cli/                   # Cloned from GitHub  
│       ├── .git -> origin (upstream)
│       └── .git -> YOUR_USERNAME (fork)
└── README.md                      # This documentation
```

## 🤖 AI Agent Coordination

### Activity Tracking

The system tracks all AI agent activities in `workspace-activity.json`:

```json
{
  "active_tasks": [
    {
      "id": "task-2025-08-15-1200-code-review",
      "type": "code-review", 
      "project": "trex",
      "assigned_agent": "claude-agent-1723716000000"
    }
  ],
  "completed_tasks": [...],
  "metrics": {
    "total_tasks": 5,
    "tasks_by_type": {"code-review": 2, "project-setup": 1}
  }
}
```

### Multi-Agent Coordination

- **Task Locking**: Prevents multiple agents from working on the same task
- **Context Sharing**: Agents can see each other's work and decisions
- **Activity History**: Complete audit trail of all development activities
- **Cross-Project Tracking**: Work spanning multiple repositories is coordinated

## 🔧 Available Commands

### Workspace Management

```bash
# Set up all projects
claude-code /workspace:prime

# Check workspace status and active tasks
claude-code /workspace:status
```

### Development Operations

```bash
# Review code from a fork
claude-code /development:review

# Check current activity
claude-code /workspace:status
```

## 🎯 Demo Scenarios

### Scenario 1: Code Review Workflow

1. **Start a review**:
   ```bash
   claude-code /development:review
   # Agent claims task, updates activity log
   ```

2. **Check activity**:
   ```bash
   cat workspace-activity.json | jq '.active_tasks'
   # Shows in-progress code review
   ```

3. **Complete review**:
   ```bash
   # Agent finishes, moves task to completed_tasks
   cat workspace-activity.json | jq '.completed_tasks[-1]'
   ```

### Scenario 2: Multi-Project Development

1. **Work on TRex template**:
   ```bash
   cd projects/rh-trex
   # Make changes, agent tracks context
   ```

2. **Apply learnings to OCM CLI**:
   ```bash
   cd ../ocm-cli  
   # Agent has context from TRex work
   ```

3. **View cross-project activity**:
   ```bash
   cat workspace-activity.json | jq '.metrics.tasks_by_project'
   ```

### Scenario 3: Fork-Based Development

The system automatically configures your forks:

```bash
cd projects/rh-trex
git remote -v
# origin: upstream repository (read-only)
# YOUR_USERNAME: your fork (read-write)

# Push to your fork
git push YOUR_USERNAME feature-branch

# Create PR to upstream  
gh pr create --base main --head YOUR_USERNAME:feature-branch
```

## 📊 Architecture Highlights

### 1. **Unified Configuration**
- Single `workspace-config.json` manages all projects
- Platform-agnostic (GitHub + GitLab)
- Rich metadata with tags, priorities, descriptions

### 2. **Activity Tracking**
- Real-time task coordination between AI agents
- Complete development history with context
- Cross-project relationship tracking

### 3. **Fork-Based Workflow**
- Secure separation of upstream vs personal repositories
- Automated remote configuration
- Safe contribution workflow

### 4. **Monodirectory Benefits**
- All projects accessible in single context
- Unified search across entire codebase: `rg "SomeFunction" projects/`
- Shared tooling and scripts

## 🔍 Deep Dive: JSON Structure

### Project Configuration

```json
{
  "alias": "trex",                    // Short reference name
  "name": "rh-trex",                  // Repository name  
  "platform": "github",              // github | gitlab
  "ssh_url": "git@github.com:...",   // Clone URL
  "local_path": "./projects/rh-trex", // Where to clone
  "branch": "main",                   // Default branch
  "tags": ["SDK", "Template"],       // Classification
  "priority": "high",                // high | medium | low
  "active": true                     // Include in operations
}
```

### Activity Tracking

```json
{
  "id": "task-2025-08-15-1200-code-review",
  "type": "code-review",             // Task category
  "project": "trex",                 // Which project
  "status": "in-progress",           // current state
  "assigned_agent": "claude-...",    // Which AI agent  
  "context": {                       // Rich context data
    "commits_reviewed": ["abc123"],
    "files_analyzed": 5
  },
  "progress": {                      // Detailed progress
    "completed_steps": ["analysis"],
    "current_step": "documentation", 
    "remaining_steps": ["summary"]
  }
}
```

## 🎨 Customization

### Adding Projects

Edit `workspace-config.json`:

```json
{
  "projects": [
    {
      "alias": "my-project",
      "name": "my-awesome-project", 
      "platform": "github",
      "url": "https://github.com/username/my-awesome-project.git",
      "ssh_url": "git@github.com:username/my-awesome-project.git",
      "description": "My awesome project description",
      "local_path": "./projects/my-awesome-project",
      "branch": "main",
      "tags": ["web", "typescript"],
      "priority": "medium",
      "active": true,
      "last_synced": "2025-08-15T12:00:00Z"
    }
  ]
}
```

### Customizing Commands

Edit files in `.claude/commands/` to modify AI agent behavior:

- `workspace/prime.md` - Project setup workflow
- `development/review.md` - Code review process  
- `workspace/status.md` - Status reporting

## 🔧 Troubleshooting

### SSH Key Issues

```bash
# Test GitHub connection
ssh -T git@github.com

# Test GitLab connection  
ssh -T git@gitlab.com

# Add your SSH key if needed
ssh-add ~/.ssh/id_rsa
```

### Git Remote Issues

```bash
# Check remotes are configured correctly
cd projects/rh-trex
git remote -v

# Should show:
# origin: upstream repository
# YOUR_USERNAME: your fork
```

### Activity Log Issues

```bash
# Validate JSON structure
cat workspace-activity.json | jq .

# Check for active tasks
cat workspace-activity.json | jq '.active_tasks | length'
```

## 🚀 Next Steps

1. **Try the commands**: Run `claude-code /workspace:status` to see current activity
2. **Explore projects**: Navigate to `projects/rh-trex` and examine the codebase
3. **Review activity**: Check `workspace-activity.json` to see tracked operations
4. **Customize**: Add your own projects to the configuration
5. **Scale**: Use this pattern for your own multi-project workspace

## 💡 Discussion Points

This demo raises interesting questions about workspace management:

- **Scale**: How does file-based coordination scale vs database solutions?
- **Intelligence**: Should workspace management be reactive or predictive?
- **Multi-agent**: How do we handle conflicts between AI agents?
- **Complexity**: Is zero-dependency simplicity worth potential coordination issues?

## 📚 Further Reading

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Workspace Architecture Patterns](./README.md)
- [Multi-Agent Coordination Strategies](./docs/multi-agent-patterns.md)

---

**Happy coding! This workspace management system transforms how you coordinate development across multiple projects with AI assistance.** 🤖✨