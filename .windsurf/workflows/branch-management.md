---
description: Manage branches and pull requests following GitHub Flow
---

# Branch Management Workflow

This workflow enforces the GitHub Flow branching model with protected branches and required checks.

## Branch Naming Conventions

- `main` - Production-ready code
- `development` - Integration branch for features (optional)
- `feature/*` - New features (e.g., `feature/user-authentication`)
- `bugfix/*` - Bug fixes (e.g., `bugfix/login-error`)
- `hotfix/*` - Critical production fixes (e.g., `hotfix/security-patch`)

## Workflow Steps

### 1. Create a New Feature Branch

```bash
git checkout main
git pull origin main
git checkout -b feature/your-feature-name
```

### 2. Make Changes and Commit

```bash
# Make your changes
git add .
git commit -m "Add your feature"
```

### 3. Push and Create Pull Request

```bash
git push -u origin feature/your-feature-name
# Then create a PR from GitHub UI or using the CLI
```

### 4. Code Review

- Request reviews from team members
- Address review comments
- Update your branch with latest changes from main if needed

### 5. Merge and Deploy

- After approval, squash and merge your PR
- Delete the feature branch
- Deploy the updated main branch

## Required Branch Protection Rules

1. **main branch protection**
   - Require pull request reviews before merging
   - Require status checks to pass
   - Require branches to be up to date before merging
   - Do not allow bypassing the above settings

2. **development branch (if used)**
   - Same as main branch protection
   - Consider requiring fewer approvals if needed

## PR Guidelines

- Keep PRs small and focused
- Include a clear description of changes
- Reference related issues
- Update documentation if needed
- Ensure all tests pass

## Workflow Automation

This workflow integrates with the following GitHub Actions:
- `ci-cd.yml` - Runs tests and checks on PRs
- `deploy.yml` - Handles deployment (when ready)
