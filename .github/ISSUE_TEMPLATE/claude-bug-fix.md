<!-- .github/ISSUE_TEMPLATE/claude-bug-fix.md -->
---
name: 🐛 Claude Bug Fix
about: Request automated bug fixing
title: '[Bug Fix] '
labels: claude-dev, bug
assignees: ''
---

## 🐛 Bug Description

**What's broken:**
Login form doesn't validate email format

**Expected behavior:**
Should show error for invalid emails

**Current behavior:**
Accepts any input and crashes on submit

**Steps to reproduce:**
1. Go to login page
2. Enter "notanemail" in email field
3. Click submit
4. See error

**Error messages:**
```
TypeError: Cannot read property 'includes' of undefined
  at validateEmail (auth.ts:45)
```

**Files involved:**
- `src/app/login/page.tsx`
- `src/lib/auth.ts`

---

## 🔧 Fix Request

Comment `/claude-build` to trigger automated fix with Haiku 4.5
