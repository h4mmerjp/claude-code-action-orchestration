<!-- .github/ISSUE_TEMPLATE/claude-feature-request.md -->
---
name: ✨ Claude Feature Request
about: Request new feature implementation
title: '[Feature] '
labels: claude-dev, enhancement
assignees: ''
---

## ✨ Feature Request

**Feature:** Dark mode support

**Description:**
Add system-wide dark mode that:
- Detects system preference
- Allows manual toggle
- Persists user choice
- Applies to all pages

**Technical Requirements:**
- Use next-themes package
- Add toggle in navbar
- Store preference in localStorage
- Implement with Tailwind dark: classes

**Design:**
- Moon/sun icon toggle
- Smooth transitions
- Accessible (keyboard navigation)

---

## 🎯 Trigger

Comment `/claude-build` to implement this feature
