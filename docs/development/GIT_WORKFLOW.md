# Git Workflow Guide

## Overview

This document describes the Git workflow and best practices for the IoTBay project.

## Branch Strategy

### Main Branches

- **main**: Production-ready code
- **develop**: Integration branch for features

### Supporting Branches

- **feature/**: New features
- **fix/**: Bug fixes
- **hotfix/**: Critical production fixes
- **release/**: Preparing a new release

## Workflow

### Starting a New Feature

```bash
# Switch to develop branch
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feature/user-authentication

# Make changes and commit
git add .
git commit -m "feat(auth): add login functionality"

# Push to remote
git push origin feature/user-authentication
```

### Committing Changes

1. **Stage changes**:
   ```bash
   git add <files>
   ```

2. **Commit with proper message**:
   ```bash
   git commit
   # This will open the commit template
   ```

3. **Or commit directly**:
   ```bash
   git commit -m "feat(scope): brief description"
   ```

### Commit Message Best Practices

✅ **Good**:
- `feat(auth): add password reset`
- `fix(cart): resolve quantity update issue`
- `docs(api): update endpoint documentation`

❌ **Bad**:
- `fixed bug`
- `update`
- `changes`
- `WIP`
- `asdf`

### Before Pushing

1. **Check status**:
   ```bash
   git status
   ```

2. **Review changes**:
   ```bash
   git diff
   ```

3. **Ensure no sensitive data**:
   - No passwords
   - No API keys
   - No database credentials
   - No `.db` files

4. **Run tests** (if applicable):
   ```bash
   mvn test
   ```

### Pushing Changes

```bash
# Push feature branch
git push origin feature/your-feature

# Or push with tracking
git push -u origin feature/your-feature
```

### Merging

1. **Update develop branch**:
   ```bash
   git checkout develop
   git pull origin develop
   ```

2. **Merge feature**:
   ```bash
   git merge feature/your-feature
   ```

3. **Resolve conflicts** (if any)

4. **Push**:
   ```bash
   git push origin develop
   ```

### Hotfix Workflow

```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/security-patch

# Make fix
git commit -m "fix(security): patch XSS vulnerability"

# Merge to both main and develop
git checkout main
git merge hotfix/security-patch
git push origin main

git checkout develop
git merge hotfix/security-patch
git push origin develop
```

## Common Commands

### Viewing History

```bash
# View commit history
git log

# View with graph
git log --oneline --graph --all

# View specific file history
git log --follow -- <file>
```

### Undoing Changes

```bash
# Unstage files
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

# Apply stash
git stash apply

# Apply and remove
git stash pop
```

### Branch Management

```bash
# List branches
git branch

# List all branches (including remote)
git branch -a

# Delete local branch
git branch -d <branch>

# Delete remote branch
git push origin --delete <branch>
```

## Ignored Files

The following are automatically ignored by Git (see `.gitignore`):

- Compiled files (`.class`, `.jar`, `.war`)
- TypeScript compiled JavaScript (`.js`, `.d.ts`, `.map`)
- Node modules (`node_modules/`)
- Build artifacts (`target/`, `dist/`, `build/`)
- Database files (`.db`, `.sqlite`)
- IDE files (`.idea/`, `.vscode/`, etc.)
- Log files (`.log`)
- Temporary files (`.tmp`, `.temp`)
- Archive files (`.zip`, `.tar.gz`)

## Troubleshooting

### Merge Conflicts

1. Identify conflicted files:
   ```bash
   git status
   ```

2. Open files and resolve conflicts (look for `<<<<<<<`, `=======`, `>>>>>>>`)

3. Stage resolved files:
   ```bash
   git add <resolved-files>
   ```

4. Complete merge:
   ```bash
   git commit
   ```

### Accidental Commit of Sensitive Data

1. Remove from history:
   ```bash
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch <file>" \
     --prune-empty --tag-name-filter cat -- --all
   ```

2. Force push (⚠️ coordinate with team):
   ```bash
   git push origin --force --all
   ```

### Large Files

If you accidentally commit large files:

1. Remove from Git:
   ```bash
   git rm --cached <large-file>
   ```

2. Add to `.gitignore`

3. Commit:
   ```bash
   git commit -m "chore: remove large file from tracking"
   ```

## Best Practices

1. **Commit often**: Small, focused commits are better
2. **Write clear messages**: Follow commit message convention
3. **Review before pushing**: Check `git status` and `git diff`
4. **Don't commit sensitive data**: Use environment variables
5. **Keep branches up to date**: Regularly merge `develop` into feature branches
6. **Use meaningful branch names**: Follow naming conventions
7. **Test before committing**: Ensure code works
8. **Don't force push to main**: Protect main branch

## Resources

- [Git Documentation](https://git-scm.com/doc)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)

