---
description: Generate a detailed task list from a PRD document
---

# Task Generation Workflow

This workflow helps you create a detailed, actionable task list from an existing Product Requirements Document (PRD).

## Prerequisites
- A completed PRD document in the `/tasks/` directory
- The PRD should follow the standard PRD format with clear functional requirements

## Step 1: Select PRD
1. List all available PRDs in the `/tasks/` directory
2. Ask the user to specify which PRD to use for task generation

## Step 2: Analyze PRD and Existing Codebase
1. Review the PRD to understand:
   - Functional requirements
   - User stories
   - Technical considerations
   - Success criteria
   - Existing implementation analysis (section 7.1)
2. Identify the main components and features that need implementation
3. Analyze the existing codebase to find:
   - Similar or related implementations that can be extended
   - Code patterns to follow for consistency
   - Potential conflicts or dependencies
   - Components that can be reused vs. those that need to be created

## Step 3: Generate Parent Tasks
1. Create high-level parent tasks (typically 3-7) that cover the main implementation areas
2. Present these to the user for review
3. Wait for user confirmation ("Go") before proceeding

## Step 4: Generate Sub-Tasks
After user confirmation:
1. Break down each parent task into smaller, actionable sub-tasks
2. Ensure each sub-task is:
   - Specific and clear
   - Actionable (starts with a verb)
   - Small enough to be completed in a few hours to a day
   - Testable

## Step 5: Identify Relevant Files
For each task, identify and list:
- New files that need to be created
- Existing files that need modification
- Existing files that can be extended or reused
- Test files that should be created/updated
- Configuration files that might need changes
- Integration points with existing code

## Step 6: Create Task List
Generate a markdown file with this structure:

```markdown
## Relevant Files

### Existing Files to Modify/Extend
- `path/to/file1.ts` - Brief description of relevance and needed changes
- `path/to/component/Component.tsx` - Main component to extend for feature X

### New Files to Create
- `path/to/newFile.ts` - New functionality to implement
- `path/to/component/NewComponent.tsx` - New component for feature Y

### Test Files
- `path/to/file1.test.ts` - Unit tests for file1.ts
- `path/to/component/Component.test.tsx` - Tests for Component
- `path/to/newFile.test.ts` - Tests for new functionality

## Notes

- Place unit tests alongside the code they test
- Use `npx jest` to run tests
- Follow the project's coding standards and conventions

## Tasks

- [ ] 1.0 Parent Task 1
  - [ ] 1.1 First sub-task
  - [ ] 1.2 Second sub-task
- [ ] 2.0 Parent Task 2
  - [ ] 2.1 First sub-task
```

## Step 7: Save Task List
1. Save the generated task list in the `/tasks/` directory
2. Use the naming convention: `tasks-[prd-filename].md`
   - Example: If PRD is `prd-user-profile.md`, save as `tasks-prd-user-profile.md`

## Best Practices
- Keep tasks small and focused (1-4 hours of work)
- Include testing tasks for each functional component
- Consider dependencies between tasks
- Add relevant file paths to help with navigation
- Include any special instructions or considerations from the PRD
- Prioritize extending existing code over creating new implementations
- Document integration points with existing systems
- Identify potential conflicts with existing functionality
- Consider backward compatibility requirements