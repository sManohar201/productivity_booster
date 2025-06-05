---
description: Create a detailed Product Requirements Document (PRD) for new features
---

# PRD Creation Workflow

This workflow guides you through creating a comprehensive Product Requirements Document (PRD) for new features.

## Step 1: Analyze Existing Codebase
1. Examine the codebase to identify any existing implementations or partial implementations of the requested feature
2. Document the current state of related functionality:
   - Existing components or modules that relate to the feature
   - Code patterns and architectural approaches used in similar features
   - Potential integration points for the new feature
   - Existing code that could be extended rather than replaced

## Step 2: Gather Requirements
1. Ask the user for a brief description of the feature they want to implement
2. Use the following questions to gather more details:
   - What problem does this feature solve?
   - Who is the primary user of this feature?
   - What are the key actions a user should be able to perform?
   - Are there any design or UI/UX requirements?
   - What are the success criteria for this feature?
   - Are there existing implementations that should be integrated with or replaced?

## Step 3: Create PRD Structure
Create a new markdown file in the `/tasks` directory with the following structure:

```markdown
# [Feature Name] - Product Requirements Document

## 1. Introduction/Overview
[Brief description of the feature and the problem it solves]

## 2. Goals
- [List specific, measurable objectives]

## 3. User Stories
- As a [type of user], I want to [perform an action] so that [benefit].
- [Add more user stories as needed]

## 4. Functional Requirements
1. [Requirement 1: Clear, specific functionality]
2. [Requirement 2: Another specific functionality]

## 5. Non-Goals (Out of Scope)
- [What this feature will not include]

## 6. Design Considerations
[Link to mockups or describe UI/UX requirements]

## 7. Technical Considerations
[Any known technical constraints or dependencies]

## 7.1 Existing Implementations
[Analysis of existing code related to this feature]
- [Current implementation status]
- [Components that can be reused or extended]
- [Code that needs to be modified or replaced]

## 8. Success Metrics
[How will the success of this feature be measured?]

## 9. Open Questions
[Any remaining questions or areas needing clarification]
```

## Step 4: Review and Refine
1. Review the PRD with stakeholders
2. Update the document based on feedback
3. Ensure all requirements are clear and testable

## Step 5: Implementation
- The PRD is now ready to guide development
- Developers should refer to this document during implementation
- Update the PRD if requirements change during development
- When implementing, always check if you can extend existing code rather than creating new components

## Best Practices
- Keep requirements clear and concise
- Use simple, unambiguous language
- Make requirements testable
- Include acceptance criteria for each requirement
- Keep the document updated as the project evolves
- Prioritize extending existing code over creating new implementations
- Document integration points with existing systems
- Consider backward compatibility with existing features

## Output
- File location: `/tasks/prd-[feature-name].md`
- Format: Markdown (.md)
- Naming convention: `prd-[feature-name].md` (use kebab-case for feature names)

