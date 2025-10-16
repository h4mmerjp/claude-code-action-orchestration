# docs/WORKFLOW_GUIDE.md

# 📖 Claude Development Workflow Guide

Complete guide to using Claude Dev Orchestration for automated development.

---

## 🚀 Quick Start

### Method 1: Create Issue with Label

1. Go to **Issues** → **New Issue**
2. Select **"🤖 Claude Full-Stack Development"** template
3. Fill in the requirements
4. Issue is automatically labeled with `claude-dev`
5. Workflow starts automatically

### Method 2: Comment Trigger

On any existing issue:
```
/claude-build

[Optional: Add or update requirements here]
```

---

## 📋 Issue Template Guide

### Full-Stack Development Template
```markdown
## 📝 Project Specification

**Project Name:** My App
**Tech Stack:** Next.js 15, TypeScript, Stripe, SQLite
**Features:**
- Feature 1
- Feature 2
```

**Tips:**
- Be specific about tech stack
- List features clearly
- Include any special requirements
- Mention third-party integrations

---

## 🔄 Workflow Phases

### Phase 1: Strategic Planning (2-3 min)
**Model:** Sonnet 4.5  
**Purpose:** High-level architecture

**What happens:**
- Analyzes requirements
- Designs architecture
- Creates database schema
- Plans API structure
- Breaks into parallel tasks

**Output:**
- Architecture plan JSON
- Task breakdown
- Initial comment on issue

### Phase 2: Parallel Implementation (5-10 min)
**Model:** Haiku 4.5  
**Purpose:** Fast coding

**What happens:**
- Multiple tasks run simultaneously
- Frontend components created
- API routes implemented
- Database setup
- Integrations configured

**Output:**
- Complete codebase
- All files generated

### Phase 3: Integration (2-3 min)
**Model:** Sonnet 4.5  
**Purpose:** Quality assurance

**What happens:**
- Components integrated
- Types verified
- Performance optimized
- Security hardened
- Error handling added

**Output:**
- Production-ready code
- Optimized bundle

### Phase 4: Documentation (2-3 min)
**Model:** Haiku 4.5  
**Purpose:** Complete docs

**What happens:**
- README generated
- API docs created
- Deployment guide written
- Examples provided
- Tests added

**Output:**
- Comprehensive documentation

### Phase 5: Pull Request (instant)
**Automated**  
**Purpose:** Code review

**What happens:**
- PR created automatically
- Linked to original issue
- Summary generated
- Checklist provided

**Output:**
- Ready-to-review PR

---

## 💬 Using Commands

### Primary Command: /claude-build

**Basic usage:**
```
/claude-build
```
Uses the original issue description

**With new requirements:**
```
/claude-build

Create a blog platform with:
- Markdown editor
- Comment system
- User profiles
```

**Update existing project:**
```
/claude-build

Add to existing project:
- Dark mode
- i18n support
```

---

## 🛡️ Loop Prevention

### How It Works

1. **Bot Detection**
   - Username checking
   - HTML marker detection
   - Content signature matching

2. **What Gets Ignored**
   - All bot comments
   - Comments with `<!-- CLAUDE-BOT-COMMENT -->`
   - Automated status updates

3. **What Triggers Workflow**
   - Issues with `claude-dev` label
   - User comments with `/claude-build`
   - Nothing else

### Safety Features

✅ Prevents infinite loops  
✅ Ignores bot-generated content  
✅ Only human triggers allowed  
✅ Clear status messages

---

## 📊 Monitoring Progress

### In GitHub Actions

1. Go to **Actions** tab
2. Find your workflow run
3. Click to see detailed logs

### Phases to Watch

- ✅ **Validate Trigger** - Should pass immediately
- 🎯 **Strategic Planning** - ~2-3 minutes
- ⚡ **Parallel Implementation** - ~5-10 minutes
- 🔄 **Integration** - ~2-3 minutes
- 📬 **Create PR** - Instant

### Issue Updates

Bot will comment with:
- ✅ Planning complete
- 🚀 Implementation started
- 🎉 PR created

---

## 🔍 Reviewing Generated Code

### What to Check

1. **Functionality**
   - All features implemented?
   - Error handling present?
   - Edge cases covered?

2. **Code Quality**
   - TypeScript types correct?
   - Naming conventions followed?
   - Comments where needed?

3. **Security**
   - Input validation?
   - Authentication proper?
   - Secrets not committed?

4. **Performance**
   - Queries optimized?
   - Images optimized?
   - Bundle size reasonable?

### Using the PR Checklist

Every PR includes a checklist:
```markdown
✅ Pre-Merge Checklist
- [ ] Code quality verified
- [ ] Tests pass
- [ ] Security reviewed
- [ ] Documentation complete
```

---

## 🐛 Troubleshooting

### Workflow Not Triggering

**Symptoms:**
- No action after creating issue
- No response to `/claude-build`

**Solutions:**
1. Check issue has `claude-dev` label
2. Verify you're not a bot account
3. Ensure command is `/claude-build` (exact)
4. Check Actions tab for errors

### Authentication Errors

**Symptoms:**
- "Authentication failed" in logs
- "Invalid session token"

**Solutions:**
1. Regenerate session token
2. Update GitHub Secret
3. Verify Claude Pro subscription
4. Check token hasn't expired

### Generated Code Issues

**Symptoms:**
- TypeScript errors
- Missing features
- Wrong tech stack

**Solutions:**
1. Check issue description clarity
2. Re-trigger with updated requirements
3. Manual fixes in PR
4. Report issue for improvement

---

## 💡 Best Practices

### Writing Good Requirements

**Do:**
- ✅ Be specific about tech stack
- ✅ List features clearly
- ✅ Mention integrations explicitly
- ✅ Include database needs

**Don't:**
- ❌ Be vague ("make it good")
- ❌ Assume defaults
- ❌ Skip important details
- ❌ Mix multiple projects

### Iterating on Results

If the first result isn't perfect:

1. **Review the PR**
2. **Comment with improvements**
3. **Trigger again:**
```
   /claude-build
   
   Update the previous implementation:
   - Add feature X
   - Fix issue Y
   - Improve Z
```

### Managing Multiple Projects

- One issue per project
- Use clear project names
- Link related issues
- Track in project boards

---

## 📈 Performance Tips

### Faster Development

1. **Clear Requirements**
   - Saves planning time
   - Reduces iterations

2. **Use Templates**
   - Pre-filled structure
   - Consistent format

3. **Parallel Features**
   - Independent features faster
   - Haiku 4.5 speed advantage

### Cost Optimization

Current strategy already optimal:
- ✅ 70% Haiku (cheap & fast)
- ✅ 30% Sonnet (strategic only)
- ✅ 50-60% cost savings
- ✅ 2-3x speed improvement

---

## 🎯 Example Workflows

### Example 1: Simple CRUD App

**Issue:**
```markdown
**Project:** Task Manager
**Tech:** Next.js, TypeScript, SQLite
**Features:**
- Create/read/update/delete tasks
- Mark as complete
- Filter by status
```

**Timeline:** ~10 minutes
**Result:** Complete app with CRUD operations

### Example 2: SaaS Application

**Issue:**
```markdown
**Project:** Analytics Dashboard
**Tech:** Next.js, TypeScript, Stripe, PostgreSQL
**Features:**
- User authentication
- Subscription plans (Stripe)
- Dashboard with charts
- API for data ingestion
- Admin panel
```

**Timeline:** ~15 minutes
**Result:** Full SaaS with payments

### Example 3: Bug Fix

**Issue:**
```markdown
**Bug:** Login form validation broken
**Files:** src/app/login/page.tsx
**Fix:** Add email validation
```

**Timeline:** ~5 minutes
**Result:** Fixed validation

---

## 📚 Additional Resources

- [Setup Guide](CLAUDE_SETUP.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Cost Optimization](COST_OPTIMIZATION.md)
- [Main README](../README.md)

---

**Questions?** Create an issue with label `help`
