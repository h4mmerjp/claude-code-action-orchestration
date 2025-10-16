# docs/CLAUDE_SETUP.md

# 🚀 Claude Development Orchestration Setup Guide

## Prerequisites

- GitHub repository with Actions enabled
- Claude Pro or Team subscription
- Node.js 20+ installed locally (for testing)

---

## Step 1: GitHub Secrets Configuration

Navigate to your repository's **Settings → Secrets and variables → Actions**

Add the following secrets:

### Required Secrets

| Secret Name | Description | How to Get |
|------------|-------------|------------|
| `CLAUDE_SESSION_TOKEN` | Claude Pro session token | See below |
| `ANTHROPIC_API_KEY` | Optional: For API usage | anthropic.com |

### Optional Secrets (for MCP servers)

| Secret Name | Description |
|------------|-------------|
| `BRAVE_API_KEY` | For web search |
| `NOTION_API_KEY` | For documentation |
| `STRIPE_API_KEY` | For payment integration |

---

## Step 2: Get Claude Session Token

### Method 1: Browser DevTools

1. Go to [claude.ai](https://claude.ai) and log in
2. Open DevTools (F12)
3. Go to **Application** tab → **Cookies**
4. Find cookie named `sessionKey`
5. Copy the value
6. Add to GitHub Secrets as `CLAUDE_SESSION_TOKEN`

### Method 2: CLI Authentication
```bash
# Install Claude CLI (if available)
npm install -g @anthropic-ai/claude-cli

# Login
claude login

# Get session token
cat ~/.config/claude/session_token
```

---

## Step 3: Workflow Files Setup

Copy all workflow files to your repository:
```bash
# Clone the workflows
mkdir -p .github/workflows
cd .github/workflows

# Copy the main workflow
curl -o claude-dev-orchestration.yml \
  https://raw.githubusercontent.com/your-repo/workflows/main/claude-dev-orchestration.yml

# Copy the review workflow
curl -o claude-code-review.yml \
  https://raw.githubusercontent.com/your-repo/workflows/main/claude-code-review.yml
```

---

## Step 4: Issue Templates Setup
```bash
mkdir -p .github/ISSUE_TEMPLATE

# Copy templates
cd .github/ISSUE_TEMPLATE
# Add your template files
```

---

## Step 5: Test the Setup

### Create Test Issue

1. Go to **Issues** → **New Issue**
2. Choose "🤖 Claude Full-Stack Development"
3. Fill in the template
4. Add label `claude-dev`
5. Submit

### Verify Workflow

1. Go to **Actions** tab
2. You should see workflow running
3. Check logs for any errors

---

## Step 6: Monitor Usage

### View Workflow Runs

- **Actions** tab shows all runs
- Click on a run to see detailed logs
- Check job durations and model usage

### Weekly Reports

The monitoring workflow creates weekly usage reports automatically.

---

## Troubleshooting

### Workflow Not Triggering

**Check:**
- Issue has correct label (`claude-dev`)
- Comment contains `/claude-build`
- Not a bot comment

### Authentication Errors

**Solutions:**
- Verify `CLAUDE_SESSION_TOKEN` is correct
- Token may have expired (refresh every 30 days)
- Check Claude Pro subscription is active

### MCP Server Errors

**Solutions:**
- Verify all required secrets are set
- Check MCP server installation
- Review logs for specific errors

---

## Best Practices

1. **Session Token Rotation**
   - Update token monthly
   - Use GitHub Actions secrets rotation

2. **Cost Monitoring**
   - Review weekly usage reports
   - Adjust Haiku/Sonnet balance as needed

3. **Security**
   - Never commit secrets to repository
   - Use GitHub Secrets for all sensitive data
   - Rotate tokens regularly

---

## Next Steps

- [Workflow Usage Guide](WORKFLOW_GUIDE.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Cost Optimization](COST_OPTIMIZATION.md)

---

**Need Help?** Create an issue with label `help`
