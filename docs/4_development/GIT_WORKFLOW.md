# Git Workflow Guide

This guide describes the Git workflow, branching strategy, and best practices for IoT Bay development.

---

## 🌿 Branch Strategy

### Main Branches

| Branch | Purpose | Protection |
|---|---|---|
| `main` | Production-ready code | Protected, requires PR review |
| `develop` | Integration branch | Protected, requires PR review |

### Supporting Branches

| Type | Format | Purpose |
|---|---|---|
| Feature | `feat/<description>` | New features |
| Fix | `fix/<description>` | Bug fixes |
| Hotfix | `hotfix/<description>` | Critical production fixes |
| Release | `release/<version>` | Preparing releases |

---

## 🚀 Feature Development Workflow

### 1. Start New Feature

```bash
# Update develop branch
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feat/user-authentication
```

### 2. Make Changes

```bash
# Stage changes
git add src/...

# Commit with proper message
git commit -m "feat(auth): add login functionality"

# Review changes
git log --oneline -5
```

### 3. Push to Remote

```bash
# Push to feature branch
git push -u origin feat/user-authentication
```

### 4. Create Pull Request

- Title: Follow commit message format
- Description: What, why, how to test
- Reviewers: Assign team members
- Labels: bug, feature, docs, etc.

### 5. Merge After Review

```bash
# After PR approval and tests passing
git checkout develop
git pull origin develop
git merge feat/user-authentication
git push origin develop

# Delete feature branch
git branch -d feat/user-authentication
git push origin --delete feat/user-authentication
```

---

## 🐛 Bugfix Workflow

```bash
# Create fix branch from develop
git checkout develop
git pull origin develop
git checkout -b fix/cart-quantity-bug

# Make fix and commit
git add src/...
git commit -m "fix(cart): resolve quantity update issue"

# Push and create PR (same as feature)
git push -u origin fix/cart-quantity-bug
```

---

## 🚨 Hotfix Workflow (Production Issues)

```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/security-patch

# Make fix
git commit -m "fix(security): patch XSS vulnerability"

# Merge to main
git checkout main
git merge hotfix/security-patch
git push origin main
git tag v1.0.1

# Also merge to develop
git checkout develop
git merge hotfix/security-patch
git push origin develop

# Delete hotfix branch
git branch -d hotfix/security-patch
```

---

## 📝 Commit Message Format

See [Contributing Guide](./CONTRIBUTING.md#-git-commit-message-convention) for detailed format.

### Quick Reference

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Examples

```bash
# Simple commit
git commit -m "feat(auth): add password reset"

# With body (opens editor)
git commit

# Type + scope combination examples
git commit -m "feat(cart): add coupon support"
git commit -m "fix(checkout): resolve payment timeout"
git commit -m "docs(api): update endpoint specs"
git commit -m "refactor(dao): improve query performance"
git commit -m "test(auth): add login validation tests"
git commit -m "perf(products): optimize search query"
```

---

## 🔍 Viewing History

### Log Commands

```bash
# Simple log
git log --oneline -10

# Graph view
git log --oneline --graph --all -20

# By author
git log --author="john.doe" --oneline

# By date
git log --since="2 weeks ago" --oneline

# File history
git log --follow -- src/main/java/User.java
```

### Diff Commands

```bash
# Changes in working directory
git diff

# Changes staged for commit
git diff --cached

# Difference between branches
git diff develop..feat/my-feature

# Specific file diff
git diff -- src/main/java/User.java
```

---

## ✅ Before Pushing Checklist

- [ ] Run tests: `mvn test`
- [ ] Check status: `git status`
- [ ] Review changes: `git diff`
- [ ] No sensitive data (passwords, keys, credentials)
- [ ] No large files (> 10 MB)
- [ ] No `.db` files or build artifacts
- [ ] Commit message follows format
- [ ] Branch name follows convention

---

## 🔄 Common Tasks

### Undo Changes

```bash
# Unstage file
git reset HEAD <file>

# Discard changes in working directory
git checkout -- <file>

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

### Stashing

```bash
# Save current changes
git stash

# List stashes
git stash list

# Apply stash (keep it)
git stash apply stash@{0}

# Apply and remove stash
git stash pop
```

### Branch Management

```bash
# List local branches
git branch

# List all branches
git branch -a

# Rename branch
git branch -m old-name new-name

# Delete local branch
git branch -d feature-branch

# Delete remote branch
git push origin --delete feature-branch
```

### Merge Conflicts

```bash
# Identify conflicted files
git status

# Open conflicted file and resolve
# (look for <<<<<<, ======, >>>>>> markers)

# Stage resolved files
git add <resolved-files>

# Complete merge
git commit
```

---

## 🚫 What NOT to Commit

The following are in `.gitignore` and should NOT be committed:

| Item | Reason | Example |
|---|---|---|
| Compiled files | Not source code | `.class`, `.jar` |
| Build artifacts | Generated | `target/`, `dist/` |
| Database files | Local data | `.db`, `.sqlite` |
| IDE settings | Personal preferences | `.idea/`, `.vscode/` |
| Node modules | Build dependency | `node_modules/` |
| Sensitive data | Security risk | passwords, API keys |
| Large files | Repository bloat | > 10 MB files |
| Log files | Runtime artifacts | `*.log` |

---

## 🆘 Troubleshooting

### "Merge conflict" when pulling

```bash
# View conflicted files
git status

# Resolve conflicts in editor
# Then stage and commit
git add <resolved-files>
git commit
```

### "Accidentally pushed to wrong branch"

```bash
# Revert on remote
git revert HEAD
git push origin branch-name
```

### "Lost commits after reset"

```bash
# Find lost commits
git reflog

# Restore
git cherry-pick <commit-hash>
```

### "Large file was committed"

```bash
# Remove from Git history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch <file>" \
  --prune-empty --tag-name-filter cat -- --all

# Force push (coordinate with team)
git push origin --force --all
```

---

## 📚 Resources

- [Official Git Documentation](https://git-scm.com/doc)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flow Model](https://nvie.com/posts/a-successful-git-branching-model/)

---

## 🔗 Related Documentation

- [Contributing Guide](./CONTRIBUTING.md)
- [Code Style Guide](./CODE_STYLE.md)
- [Development Setup](./README.md)

---

**Last Updated**: December 3, 2025  
**Version**: 1.0.0
