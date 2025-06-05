---
trigger: manual
---

# Development Rules - Part 1/2

## 1. Project Structure
- Use consistent folder organization with clear separation of concerns
- Frontend: components, hooks, services, types, utils, store, features
- Backend: apps, models, views, serializers, services, utils, tests
- Keep files under 400 lines of code
- Follow Django app-based architecture for backend
- Use feature-based folder structure for React components

## 2. TypeScript Rules
- Use strict mode with explicit types
- Never use `any` type - use `unknown` if needed
- Define interfaces for API responses/requests
- Use type guards and proper type narrowing
- Generate shared types from Django models when possible
- Use generic types for reusable components

## 3. Code Quality
- Follow ESLint and Prettier configs
- Single responsibility principle for functions
- Clean, readable, maintainable code
- Meaningful names (no abbreviations)
- JSDoc for complex logic and public APIs
- Consistent error handling
- Consistent naming across frontend/backend

## 4. Performance Optimization
- Code splitting and lazy loading for React
- Strategic use of React.memo, useMemo, useCallback
- Minimize unnecessary re-renders
- Dynamic imports for heavy libraries
- Small, focused components
- Pagination for large datasets
- Optimize DB queries with select_related/prefetch_related
- Implement caching (Redis, browser cache, CDN)

## 5. State Management (Redux + RTK Query)
- Redux Toolkit for global state
- RTK Query for all API calls
- Feature-based slice structure
- Normalized state shape
- Proper error/loading states
- Built-in caching and invalidation
- Immutable state with Immer
- Avoid prop drilling

## 6. API Integration
- RTK Query for all API calls
- Consistent error handling
- DRF serializers for responses
- Strong type definitions
- Loading states and error boundaries
- Pagination for large datasets
- JWT authentication with refresh
- API response caching

## 7. Django Backend
- DRF for all endpoints
- Serializers with validation
- Built-in auth and permissions
- Services layer for business logic
- Transaction management
- Comprehensive logging
- Proper migration usage
- Security best practices

## 8. Security
- Validate/sanitize all inputs
- CSRF protection
- Proper auth/z
- Environment variables for secrets
- No sensitive data in frontend
- Proper CORS settings
- HTTPS in production
- File upload validation

## 9. Error Handling
- Global error boundary in React
- Consistent error responses
- Context-rich error logging
- User-friendly messages
- Proper async/await handling
- HTTP status codes
- Centralized error utilities
- Django logging framework

## 10. Tailwind CSS
- Consistent utility classes
- Reusable component styles
- Mobile-first responsive design
- No inline styles (except dynamic values)
- Custom theme configuration
- Utility classes for patterns
