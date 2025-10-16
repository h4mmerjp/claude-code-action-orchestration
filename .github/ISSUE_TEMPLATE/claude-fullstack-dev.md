<!-- .github/ISSUE_TEMPLATE/claude-fullstack-dev.md -->
---
name: 🤖 Claude Full-Stack Development
about: Request automated full-stack app development
title: '[Claude Dev] '
labels: claude-dev, fullstack
assignees: ''
---

## 📝 Project Specification

**Project Name:** My Awesome App

**Tech Stack:** Next.js 15, TypeScript, Stripe, SQLite, TailwindCSS

**Features:**
- User authentication (email/password)
- Subscription management with Stripe
- Dashboard with analytics
- Admin panel
- RESTful API

**Additional Requirements:**
- Responsive design (mobile/tablet/desktop)
- Dark mode support
- SEO optimization
- Rate limiting on APIs
- Comprehensive error handling

**Database Schema:**
```
Users
- id (primary key)
- email (unique)
- password_hash
- subscription_status
- created_at

Subscriptions
- id (primary key)
- user_id (foreign key)
- stripe_subscription_id
- status
- plan_type
```

**Stripe Plans:**
- Basic: $9.99/month
- Pro: $29.99/month
- Enterprise: $99.99/month

---

## 🎯 How to Use

### Automatic Trigger
This issue has the `claude-dev` label, so development will start automatically.

### Manual Trigger
Comment `/claude-build` to start or restart development.

### Update Requirements
Comment `/claude-build` with updated requirements:
```
/claude-build

Update: Add dark mode and multi-language support
```

---

## ⚠️ Important Notes

1. **Don't reply to bot comments** - Automatically ignored
2. **Wait for PR** - Review before merging
3. **Check branch** - Named `claude-dev/project-name-timestamp`

---

## 📊 Expected Timeline

- Strategic Planning: ~2 minutes
- Implementation: ~5-10 minutes (parallel)
- Integration: ~2 minutes
- Documentation: ~2 minutes
- **Total: ~10-15 minutes**

---

🤖 **Powered by Claude Haiku 4.5 + Sonnet 4.5**
