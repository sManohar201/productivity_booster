---
description: Workflow for managing and processing task lists during implementation
---

# Task List Processing Workflow

This workflow provides guidelines for managing and processing task lists during implementation, ensuring systematic progress tracking and task completion.

## Getting Started

1. **Locate Task List**
   - Navigate to the `/tasks/` directory
   - Open the task list file (typically named `tasks-prd-[feature-name].md`)

2. **Review Task List**
   - Check the "Relevant Files" section for context
   - Review all parent tasks and sub-tasks
   - Note any dependencies between tasks

## Task Implementation Process

### Before Starting Work
1. Identify the next uncompleted sub-task (first `[ ]` in the list)
2. Ensure all prerequisite tasks are completed
3. Review the task description and any associated files

### During Implementation
1. Work on **one sub-task at a time**
2. Make focused, atomic commits for each logical change
3. Update the task list file as you progress

### After Completing a Sub-task
1. Mark the sub-task as completed by changing `[ ]` to `[x]`
2. If all sub-tasks under a parent task are completed:
   - Mark the parent task as completed
3. Update the "Relevant Files" section if:
   - New files were created
   - Files were modified
   - Files were removed

4. **Pause and wait** for user confirmation before proceeding to the next sub-task
   - Present a summary of changes made
   - Ask for confirmation to proceed with the next task

## Task List Maintenance

### Updating Tasks
- Add new tasks as they are discovered
- Break down large tasks into smaller, manageable sub-tasks
- Update task descriptions if requirements change
- Move completed tasks to the bottom of their section if preferred

### File Management
- Keep the "Relevant Files" section up to date
- Include brief descriptions for each file
- Group related files together
- Include test files with their corresponding implementation files

## Best Practices

1. **Atomic Commits**
   - Each commit should represent a single logical change
   - Include the task number in commit messages (e.g., "[1.2] Implement user authentication")

2. **Frequent Updates**
   - Update the task list after each significant change
   - Don't leave tasks partially completed for too long

3. **Clear Descriptions**
   - Write clear, actionable task descriptions
   - Include acceptance criteria when helpful

4. **Testing**
   - Include testing tasks for each feature
   - Update tests as implementation progresses

## Example Task List Update

```markdown
## Relevant Files

- `src/components/UserProfile.tsx` - Main profile component
- `src/components/UserProfile.test.tsx` - Tests for UserProfile
- `src/api/users.ts` - API calls for user data

## Tasks

- [x] 1.0 User Authentication
  - [x] 1.1 Create login form
  - [x] 1.2 Implement authentication service
  - [x] 1.3 Add error handling

- [ ] 2.0 User Profile
  - [x] 2.1 Create profile component
  - [ ] 2.2 Implement profile editing
  - [ ] 2.3 Add profile picture upload
```

## Completion Protocol

1. After completing a sub-task:
   - Mark it as `[x]`
   - Check if all sub-tasks under the parent are complete
   - If yes, mark the parent task as `[x]`
   - Update the task list file
   - Commit changes
   - Wait for user confirmation before proceeding

2. When all tasks are complete:
   - Review all changes
   - Ensure all tests pass
   - Update documentation if needed
   - Mark the entire task list as complete