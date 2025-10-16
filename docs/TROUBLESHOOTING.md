# docs/TROUBLESHOOTING.md

# 🔧 Troubleshooting Guide

Common issues and solutions for Claude Dev Orchestration.

---

## 🚨 Common Issues

### 1. Workflow Not Triggering

#### Symptom
- Created issue with `claude-dev` label but nothing happens
- Commented `/claude-build` but no response

#### Diagnosis
Check Actions tab for:
- Workflow run exists but failed at `validate-trigger`
- No workflow run at all

#### Solutions

**Solution A: Label Check**
```bash
# Verify issue has correct label
# Go to issue → Labels section
# Should see "claude-dev" or "fullstack"
```

**Solution B: Comment Format**
```bash
# Correct format:
/claude-build

# Incorrect formats that won't work:
claude-build      # Missing /
/ claude-build    # Extra space
#claude-build     # Hash instead of slash
```

**Solution C: Bot Detection**
```bash
# If you're using a bot account:
# Workflow will ignore it (by design)
# Use a real user account instead
```

---

### 2. Authentication Failures

#### Symptom
```
Error: Authentication failed
Error: Invalid session token
Error: 401 Unauthorized
```

#### Diagnosis
Session token is invalid or expired

#### Solutions

**Solution A: Regenerate Token**
1. Go to https://claude.ai
2. Log in
3. Open DevTools (F12)
4. Application → Cookies
5. Copy new `sessionKey` value
6. Update GitHub Secret

**Solution B: Verify Subscription**
1. Check Claude Pro is active
2. Billing is up to date
3. No account restrictions

**Solution C: Token Format**
```bash
# Correct format:
sk-ant-xxxxxxxxxxxxx

# Common mistakes:
sessionKey=sk-ant-xxx    # Remove "sessionKey="
"sk-ant-xxx"             # Remove quotes
```

---

### 3. MCP Server Errors

#### Symptom
```
Error: Could not start MCP server: filesystem
Error: MCP server crashed
```

#### Diagnosis
MCP servers not properly installed or configured

#### Solutions

**Solution A: Reinstall MCPs**
```bash
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-brave-search
npm install -g @modelcontextprotocol/server-sqlite
```

**Solution B: Check Configuration**
```bash
# Verify config file exists
cat .github/config/mcp-config.json

# Validate JSON
jq empty .github/config/mcp-config.json
```

**Solution C: API Keys**
```bash
# For Brave Search
# Add BRAVE_API_KEY to GitHub Secrets

# For Notion
# Add NOTION_API_KEY to GitHub Secrets

# For Stripe  
# Add STRIPE_API_KEY to GitHub Secrets
```

---

### 4. Generated Code Has Errors

#### Symptom
- TypeScript compilation errors
- Missing dependencies
- Wrong file structure

#### Diagnosis
Requirements unclear or incomplete

#### Solutions

**Solution A: Re-trigger with Clarity**
```
/claude-build

IMPORTANT: Use Next.js 15 App Router (not Pages Router)
Tech Stack:
- Next.js 15.0.0
- TypeScript 5.3
- React 19
- TailwindCSS 3.4

Features:
[List very specifically]
```

**Solution B: Manual Fixes**
```bash
# Check out the PR branch
git checkout claude-dev/project-name-xxx

# Fix issues manually
# Commit and push

# Or request changes in PR review
```

**Solution C: Provide Examples**
```
/claude-build

Create like this example:
[Paste code example or reference]
```

---

### 5. Infinite Loop Detected

#### Symptom
- Multiple workflow runs triggering
- Bot commenting on own comments

#### Diagnosis
Loop prevention not working

#### Solutions

**This should never happen**, but if it does:

**Solution A: Emergency Stop**
1. Go to Actions tab
2. Cancel all running workflows
3. Check `validate-trigger` job logs

**Solution B: Verify Loop Prevention**
```bash
# Check workflow has validation
grep -n "validate-trigger" .github/workflows/claude-dev-orchestration.yml

# Should see bot detection
grep -n "github-actions\[bot\]" .github/workflows/claude-dev-orchestration.yml

# Should see comment markers
grep -n "CLAUDE-BOT-COMMENT" .github/workflows/claude-dev-orchestration.yml
```

**Solution C: Report Issue**
If loop prevention fails, it's a bug. Please report:
1. Create issue with label `bug`
2. Include workflow run URL
3. Copy comment history

---

### 6. Slow Performance

#### Symptom
- Workflow taking >20 minutes
- Stuck on one phase

#### Diagnosis
- Model rate limiting
- Network issues
- Complex requirements

#### Solutions

**Solution A: Check Rate Limits**
```bash
# Wait 1 hour and try again
# Claude Pro has usage limits
```

**Solution B: Simplify Requirements**
```
/claude-build

Start with MVP:
- Feature 1 only
- Basic functionality
- No integrations yet

[Add more later]
```

**Solution C: Break Into Steps**
```
Issue #1: /claude-build core features
Issue #2: /claude-build add authentication  
Issue #3: /claude-build add payments
```

---

### 7. PR Not Created

#### Symptom
- Workflow completes
- No PR appears

#### Diagnosis
- Branch already exists
- Permissions issue
- API error

#### Solutions

**Solution A: Check Branch**
```bash
# Go to Branches page
# Look for claude-dev/project-name-xxx
# Branch exists but no PR? Create manually
```

**Solution B: Permissions**
```yaml
# Verify workflow has permissions
permissions:
  contents: write
  issues: write
  pull-requests: write
```

**Solution C: Manual PR**
```bash
# Create PR manually from the branch
# Go to Pull Requests → New PR
# Select claude-dev/xxx branch
```

---

### 8. Missing Files in PR

#### Symptom
- Some files not generated
- Incomplete implementation

#### Diagnosis
- Task failed silently
- Parallel job failed

#### Solutions

**Solution A: Check Artifacts**
```bash
# Go to workflow run
# Check "Artifacts" section
# Download to see what was generated
```

**Solution B: Re-trigger Specific Features**
```
/claude-build

Focus only on missing parts:
- [List what's missing]
```

**Solution C: Manual Addition**
```bash
# Add missing files manually
# Follow the architecture from generated code
```

---

## 🔍 Debugging Tools

### View Workflow Logs

1. Go to **Actions** tab
2. Click on workflow run
3. Click on failed job
4. Expand steps to see logs

### Check Validation
```bash
# Run validation script locally
cd .github/scripts
./validate-workflow.sh
```

### Test Loop Prevention
```bash
# Run loop prevention test
cd .github/scripts
./test-loop-prevention.sh
```

### Monitor Usage
```bash
# Check model usage
cd .github/scripts
./monitor-claude-usage.sh
```

---

## 📊 Status Codes

| Code | Meaning | Action |
|------|---------|--------|
| 200 | Success | Normal operation |
| 401 | Auth failed | Update session token |
| 403 | Forbidden | Check permissions |
| 429 | Rate limit | Wait and retry |
| 500 | Server error | Check Claude status |

---

## 🆘 Getting Help

### Before Asking for Help

1. ✅ Read this troubleshooting guide
2. ✅ Check workflow logs
3. ✅ Run validation script
4. ✅ Verify secrets are set
5. ✅ Try re-triggering

### How to Ask for Help

Create an issue with:
- **Label:** `help`
- **Title:** Brief description
- **Body:**
```markdown
  ## Problem
  [Describe what's not working]
  
  ## What I Tried
  [List solutions you attempted]
  
  ## Workflow Run
  [Link to failed workflow run]
  
  ## Logs
```
  [Paste relevant logs]
```
  
  ## Environment
  - Repository: [public/private]
  - Claude Plan: [Pro/Team]
  - Issue: [link to issue]
```

---

## 📚 Additional Resources

- [Setup Guide](CLAUDE_SETUP.md)
- [Workflow Guide](WORKFLOW_GUIDE.md)
- [Cost Optimization](COST_OPTIMIZATION.md)
- [Claude Documentation](https://docs.claude.ai)

---

**Still stuck?** Create an issue with label `help`
