---
trigger: manual
---

# Development Rules - Part 2/2

## 11. File Upload System
- Process large uploads in batches
- Progress tracking and cancellation
- Streaming for large files
- File validation (type, size, content)
- Handle concurrent uploads
- Use S3 pre-signed URLs
- Cleanup failed uploads
- Retry logic with backoff

## 12. Database Management
- Effective ORM relationships
- Database transactions
- Connection pooling for scale
- Prevent N+1 queries
- Proper indexing
- Database constraints
- Handle race conditions

## 13. Testing
- Unit tests for critical code
- React Testing Library for frontend
- Django TestCase for backend
- Test edge cases
- Mock external services
- High coverage for critical paths
- Integration tests for workflows

## 14. Git Workflow
- Feature branch workflow
- Conventional commits
- PR review process
- Meaningful commit messages
- Squash before merging
- Tag releases

## 15. Environment Config
- .env files per environment
- No secrets in version control
- Validate env vars on startup
- Comprehensive .gitignore
- Document all required vars

## 16. Monitoring & Logging
- Structured logging
- Performance monitoring
- User interaction tracking
- System health checks
- Production monitoring

## 17. Core Principles
- **400 Line Limit**: Refactor larger files
- **Dependencies**: Check compatibility first
- **Code Reuse**: Check existing code first
- **Focused Changes**: Only modify related code
- **No Mock Data**: Use real data always
- **Helper Functions**: Small and reusable
- **Documentation**: Thorough docs for complex logic
- **Consistency**: Maintain patterns

## 18. Debugging
- Use DevTools and Django Debug Toolbar
- Comprehensive logging
- Meaningful variable names
- Helpful error messages
- TypeScript strict mode
- Environment configs

## 19. Performance
- Monitor bundle size
- Profile backend with Django tools
- Optimize database queries
- Monitor memory usage
- Regular performance testing
- Set up alerts

## 20. Accessibility
- WCAG compliance
- Semantic HTML
- ARIA attributes
- Keyboard navigation
- Screen reader testing
