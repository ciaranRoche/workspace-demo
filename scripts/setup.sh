#!/bin/bash

# Workspace Demo Setup Script
# This script helps users configure and set up the demo workspace

set -e

echo "🚀 Workspace Demo Setup"
echo "======================"

# Check if workspace-config.json exists
if [ ! -f "workspace-config.json" ]; then
    echo "❌ Error: workspace-config.json not found!"
    echo "   Make sure you're running this from the workspace-demo root directory."
    exit 1
fi

# Check if user has updated their credentials
GITHUB_USER=$(cat workspace-config.json | grep -o '"github_username": "[^"]*"' | cut -d'"' -f4)
GITLAB_USER=$(cat workspace-config.json | grep -o '"gitlab_username": "[^"]*"' | cut -d'"' -f4)

if [ "$GITHUB_USER" = "YOUR_GITHUB_USERNAME" ] || [ "$GITLAB_USER" = "YOUR_GITLAB_USERNAME" ]; then
    echo "⚠️  Please update your credentials first!"
    echo ""
    echo "Edit workspace-config.json and replace:"
    echo "  \"github_username\": \"YOUR_GITHUB_USERNAME\""
    echo "  \"gitlab_username\": \"YOUR_GITLAB_USERNAME\""
    echo ""
    echo "With your actual usernames:"
    echo "  \"github_username\": \"your-github-username\""
    echo "  \"gitlab_username\": \"your-gitlab-username\""
    echo ""
    exit 1
fi

echo "✅ Credentials configured: $GITHUB_USER (GitHub), $GITLAB_USER (GitLab)"
echo ""
echo "🎯 Next, run one of these commands:"
echo ""
echo "📦 Using Claude Code (recommended):"
echo "   claude-code /workspace:prime"
echo ""
echo "🔧 Manual setup (if Claude Code not available):"
echo "   # Create projects directory"
echo "   mkdir -p projects"
echo "   "
echo "   # Clone repositories"
echo "   git clone git@github.com:openshift-online/rh-trex.git projects/rh-trex"
echo "   git clone git@github.com:openshift-online/ocm-cli.git projects/ocm-cli"
echo "   "
echo "   # Configure your forks as remotes"
echo "   cd projects/rh-trex && git remote add $GITHUB_USER git@github.com:$GITHUB_USER/rh-trex.git"
echo "   cd ../ocm-cli && git remote add $GITHUB_USER git@github.com:$GITHUB_USER/ocm-cli.git"
echo ""
echo "📖 See DEMO.md for complete instructions!"