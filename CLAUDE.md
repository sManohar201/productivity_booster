# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an AI-powered deep work productivity application based on Cal Newport's deep work principles. The app helps users achieve sustained, distraction-free focus through intelligent scheduling, behavioral coaching, and cross-platform synchronization. Built as a cross-platform solution supporting mobile (iOS/Android) and web interfaces with a unified Django backend.

## Architecture

### Tech Stack
- **Mobile**: React Native 0.70+ with Expo, TypeScript, Redux Toolkit, React Navigation 6
- **Web**: React/Next.js with PWA capabilities for desktop browser experience
- **Backend**: Django 4.2+ with DRF, PostgreSQL, Redis, Celery
- **Infrastructure**: Docker, GitHub Actions CI/CD
- **AI Integration**: OpenAI/Mistral APIs for behavioral coaching and intelligent scheduling

### Cross-Platform Architecture
```
apps/
├── mobile/          # React Native app (iOS/Android)
├── web/             # React/Next.js web app with PWA
└── shared/          # Shared TypeScript types and utilities

backend/             # Django backend serving all platforms
├── config/          # Django settings (base, dev, prod)
└── apps/
    ├── users/       # User management and authentication
    ├── tasks/       # Task management with AI suggestions
    ├── focus/       # Focus sessions and distraction blocking
    ├── analytics/   # Productivity insights and reporting
    ├── ai/          # AI coaching and behavioral analysis
    ├── habits/      # Habit tracking and gamification
    └── integrations/ # Calendar/task manager integrations

docs/                # Project documentation
scripts/             # Setup and utility scripts
```

### Core Deep Work Features
- **Focus Session Management**: Pomodoro timers, custom intervals, visual countdown
- **Intelligent Distraction Blocking**: Website/app blocking, Do Not Disturb integration
- **Calendar Integration**: Two-way sync, time blocking, "Deep Work" event types
- **AI Coaching**: Behavioral analysis, productivity patterns, personalized recommendations
- **Habit Building**: Streak tracking, gamification, progressive goal scaling
- **Cross-Platform Sync**: Real-time session sync, universal settings, seamless handoff

## Development Commands

### Environment Setup
```bash
# One-command setup
./scripts/setup.sh    # Mac/Linux
.\scripts\setup.ps1   # Windows

# Start services
docker-compose up -d  # Backend services (PostgreSQL, Redis)
cd apps/mobile && npm start  # Mobile app development
cd apps/web && npm run dev    # Web app development
```

### Backend Development
```bash
cd backend
python manage.py runserver    # Development server
python manage.py test         # Run tests
python manage.py migrate      # Apply migrations
black .                       # Code formatting
flake8                        # Linting
```

### Mobile Development
```bash
cd apps/mobile
npm run android      # Android development
npm run ios          # iOS development
npm test             # Run tests
npm run lint         # ESLint
npm run type-check   # TypeScript checking
```

### Web Development
```bash
cd apps/web
npm run dev          # Development server
npm run build        # Production build
npm test             # Run tests
npm run lint         # ESLint
npm run type-check   # TypeScript checking
```

## Authentication Architecture

Uses Django Allauth with JWT tokens for API authentication. Supports:
- Email/password authentication with Argon2id hashing
- Social login (Google, Apple)
- Multi-factor authentication
- Secure token storage in mobile app
- Session management with refresh tokens

## Key Development Patterns

### API Structure
- RESTful APIs with Django REST Framework
- JWT authentication for mobile app
- Rate limiting on auth endpoints
- CORS configured for development/production

### Mobile App Patterns
- Redux Toolkit for state management
- React Query for server state and caching
- TypeScript for type safety
- React Hook Form for form handling
- React Native Paper for UI components
- Native modules for device-specific features (Do Not Disturb, app blocking)

### Web App Patterns
- Next.js with App Router for modern React patterns
- PWA capabilities for offline support and desktop notifications
- TanStack Query for server state management
- Tailwind CSS for styling
- Browser API integration for distraction blocking

### AI Integration
- AI services in dedicated Django app (apps/ai/)
- Background task processing with Celery
- OpenAI/Mistral API integration for task suggestions and scheduling
- Vector database integration (Pinecone/Weaviate) for semantic search

## Testing Strategy

### Backend Testing
- Pytest for Django testing
- Factory Boy for test data generation
- Coverage target: >80%
- Integration tests for AI services

### Mobile Testing
- Jest and React Native Testing Library
- Detox for E2E testing
- Platform-specific testing (iOS/Android)

### Web Testing
- Jest and React Testing Library
- Playwright for E2E testing
- PWA testing across different browsers

## Security Considerations

- Never commit API keys or secrets
- Use environment variables for configuration
- HTTPS enforcement in production
- Input validation and sanitization
- Secure token storage patterns
- Regular security audits

## Performance Requirements

- Development setup: <30 minutes
- Build time: <10 minutes
- Authentication response: <2 seconds
- AI task suggestions: <5 seconds
- 99.9% uptime target for production

## Deep Work Implementation Notes

### Focus Session Features
- Implement 15-20 minute ramp-up time for deep work flow state
- Support both Pomodoro (25/5 min) and longer blocks (60-90 min)
- Visual countdown timers with full-screen focus mode
- Automatic Do Not Disturb activation across all platforms

### Distraction Management
- Real-time behavioral monitoring with gentle nudges
- Website/app blocking during focus sessions
- Emergency bypass for critical notifications
- Cross-platform sync of distraction settings

### Habit Formation (Cue-Routine-Reward)
- Automated cues: scheduled reminders and focus prompts
- Routine: structured focus sessions with clear start/end
- Reward: visual progress, streaks, badges, completion animations

## AI/ML Specific Notes

- AI behavioral coaching based on productivity patterns
- Confidence thresholds for AI scheduling suggestions
- Real-time focus state detection and intervention
- Personalized recommendations for optimal work periods
- Cache common AI queries to reduce API costs
- Monitor AI service costs and usage patterns