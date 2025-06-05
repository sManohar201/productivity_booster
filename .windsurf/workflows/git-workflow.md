---
description: Automate Git workflows including branch creation, commits, pushes, and PRs
---

# Git Workflow Automation

This workflow helps automate common Git operations like creating branches, committing changes, pushing to remote, and creating pull requests.

## Available Actions

1. **Create Branch**
   - Creates a new branch from the specified base branch
   - Required parameters: `branch_name`
   - Optional parameters: `base_branch` (default: main)

2. **Commit Changes**
   - Stages and commits all changes with a custom message
   - Required parameters: `commit_message`

3. **Push Changes**
   - Pushes the current branch to the remote repository
   - No additional parameters required

## Usage

1. Go to Actions → Git Workflow Automation
2. Select the desired action
3. Fill in the required parameters
4. Run the workflow

## Example: Create and Push a New Feature

1. **Create Branch**
   - Action: create-branch
   - Branch name: feature/your-feature
   - Base branch: main

2. **After making changes, commit them**
   - Action: commit-changes
   - Commit message: "Add new feature implementation"

3. **Push changes**
   - Action: push-changes


## Notes

- The workflow requires `GITHUB_TOKEN` (automatically provided by GitHub)
- Ensure your repository has the necessary branch protection rules
- All actions are logged for transparency
- The workflow includes error handling and only performs actions when needed

## Workflow YAML

```yaml
name: Git Workflow Automation

on:
  workflow_dispatch:
    inputs:
      action:
        description: 'Action to perform (create-branch, commit-changes, push-changes)'
        required: true
        default: 'create-branch'
        type: choice
        options:
        - create-branch
        - commit-changes
        - push-changes
      branch_name:
        description: 'Branch name (required for create-branch)'
        required: false
        type: string
      commit_message:
        description: 'Commit message (required for commit-changes)'
        required: false
        type: string

jobs:
  git-workflow:
    name: Git Workflow
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - name: Setup Git Identity
      run: |
        git config --global user.name "${{ github.actor }}"
        git config --global user.email "${{ github.actor }}@users.noreply.github.com"

    - name: Create Branch
      if: ${{ inputs.action == 'create-branch' && inputs.branch_name != '' }}
      run: |
        git fetch origin ${{ inputs.base_branch }}:refs/remotes/origin/${{ inputs.base_branch }}
        git checkout -b ${{ inputs.branch_name }} origin/${{ inputs.base_branch }}
        echo "Created and switched to branch: ${{ inputs.branch_name }}"

    - name: Commit Changes
      if: ${{ inputs.action == 'commit-changes' && inputs.commit_message != '' }}
      run: |
        git add .
        git diff --quiet && git diff --staged --quiet || git commit -m "${{ inputs.commit_message }}"
        echo "Changes committed with message: ${{ inputs.commit_message }}"

    - name: Push Changes
      if: ${{ inputs.action == 'push-changes' }}
      run: |
        git push --set-upstream origin HEAD
        echo "Pushed changes to remote"

    - name: Create Pull Request
      if: ${{ inputs.action == 'create-pr' && inputs.branch_name != '' }}
      uses: peter-evans/create-pull-request@v5
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
        commit-message: "${{ inputs.commit_message || 'Apply automatic changes' }}"
        title: "${{ inputs.commit_message || 'Update: Automated changes' }}"
        body: "Automated PR created by GitHub Actions"
        branch: "${{ inputs.branch_name }}"
        base: "${{ inputs.base_branch }}"
        draft: false
        delete-branch: false
        team-reviewers: |
          maintainers
          developers
```