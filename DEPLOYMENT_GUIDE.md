# Productivity Booster - Complete Deployment Guide

## Table of Contents
1. [Local Development Setup](#local-development-setup)
2. [Running Web Application](#running-web-application)
3. [Running Mobile App on Android](#running-mobile-app-on-android)
4. [Running Mobile App on iPad](#running-mobile-app-on-ipad)
5. [Cost-Optimized Cloud Deployment](#cost-optimized-cloud-deployment)
6. [Troubleshooting](#troubleshooting)

---

## Local Development Setup

### Prerequisites
- **Node.js**: Version 18+ ([Download](https://nodejs.org/))
- **Python**: Version 3.10+ ([Download](https://python.org/))
- **Git**: Latest version
- **Android Studio**: For Android development
- **Xcode**: For iOS/iPad development (macOS only)

### Initial Setup
```bash
# Clone the repository
git clone <your-repo-url>
cd productivity-booster

# Install root dependencies
npm install

# Setup backend
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt

# Setup database
python manage.py migrate
python manage.py createsuperuser  # Optional: create admin user

# Go back to root
cd ..
```

---

## Running Web Application

### 1. Start Backend Server
```bash
cd backend
source venv/bin/activate  # On Windows: venv\Scripts\activate
python manage.py runserver 0.0.0.0:8000
```

**Backend will be available at**: http://localhost:8000
- API Health Check: http://localhost:8000/api/health/
- Admin Panel: http://localhost:8000/admin/ (if superuser created)

### 2. Start Frontend Server
```bash
# In a new terminal
cd apps/web
npm install  # First time only
npm run dev
```

**Web app will be available at**: http://localhost:3000

### 3. Verify Web App
1. Open browser to http://localhost:3000
2. Should see "Productivity Booster" landing page
3. Verify "Platform Status" shows:
   - ✅ Web App: Running
   - ✅ Backend API: Running
   - ⏳ Mobile App: Pending

### Development Commands
```bash
# Backend
cd backend
python manage.py test          # Run tests
python manage.py shell         # Django shell
python manage.py makemigrations # Create migrations

# Frontend  
cd apps/web
npm run build                  # Production build
npm run lint                   # ESLint
npm run type-check            # TypeScript check
```

---

## Running Mobile App on Android

### 1. Install Expo Go App
- Download **Expo Go** from Google Play Store
- Create account at https://expo.dev (optional but recommended)

### 2. Start Mobile Development Server
```bash
cd apps/mobile
npm install  # First time only
npm start
```

This will start Metro bundler and show a QR code.

### 3. Connect Android Device

#### Method A: QR Code (Recommended)
1. Ensure phone and computer are on same WiFi network
2. Open Expo Go app on Android
3. Tap "Scan QR code"
4. Scan the QR code from terminal
5. App will load on your device

#### Method B: Android Studio Emulator
1. Install Android Studio
2. Create Virtual Device (API 30+)
3. Start emulator
4. In terminal, press `a` to open on Android emulator

### 4. Development on Android
- **Hot Reload**: Changes auto-refresh
- **Debug Menu**: Shake device or Cmd+M
- **Logs**: Visible in terminal running `npm start`

### Android Testing Checklist
- [ ] App loads without crashes
- [ ] Scroll functionality works
- [ ] Touch interactions responsive
- [ ] Status cards display correctly
- [ ] Text is readable on device screen

---

## Running Mobile App on iPad

### 1. Install Expo Go on iPad
- Download **Expo Go** from App Store
- Sign in with Expo account

### 2. Connect iPad

#### Method A: QR Code
1. Ensure iPad and computer on same WiFi
2. Open Expo Go app
3. Scan QR code from terminal
4. App loads on iPad

#### Method B: iOS Simulator (macOS only)
```bash
# Install Xcode from Mac App Store
# Install iOS Simulator
cd apps/mobile
npm start
# Press 'i' to open iOS simulator
```

### 3. iPad-Specific Testing
- **Landscape/Portrait**: Rotate to test both orientations
- **Touch Targets**: Ensure buttons are easily tappable
- **Text Size**: Verify readability on larger screen
- **Layout**: Check responsive design adapts to screen size

### iPad Optimization Notes
- App automatically adapts to larger screen
- Cards stack vertically on smaller widths
- Text scales appropriately
- Touch targets meet Apple's 44pt minimum

---

## Cost-Optimized Cloud Deployment (Under $5/month)

### Architecture Overview
Instead of expensive Azure App Service, we'll use:
- **Backend**: Railway.app (Free tier + $5/month if needed)
- **Frontend**: Vercel (Free tier)
- **Database**: Railway PostgreSQL (included in $5 plan)
- **Storage**: Cloudinary (Free tier)

### Option 1: Completely Free Tier
**Cost: $0/month**

#### Backend Deployment (Railway.app - Free)
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
cd backend
railway deploy
```

**Free Tier Limits:**
- 500 hours/month execution time
- 1GB RAM
- 1GB storage

#### Frontend Deployment (Vercel - Free)
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy frontend
cd apps/web
vercel deploy --prod
```

**Free Tier Limits:**
- 100GB bandwidth/month
- Unlimited static sites

#### Database: Railway PostgreSQL (Free)
- Included in Railway free tier
- 1GB storage limit

### Option 2: Low-Cost Tier ($5/month)
**Cost: $5/month total**

#### Backend: Railway Pro Plan ($5/month)
- **Execution Time**: Unlimited
- **RAM**: Up to 8GB
- **Storage**: 100GB
- **Database**: PostgreSQL included
- **Custom Domains**: Included

#### Frontend: Vercel (Free)
- Same as Option 1

### Deployment Steps

#### 1. Prepare Backend for Railway
```bash
cd backend

# Create Procfile
echo "web: gunicorn config.wsgi --log-file -" > Procfile

# Create railway.json
cat > railway.json << EOF
{
  "build": {
    "builder": "nixpacks"
  },
  "deploy": {
    "startCommand": "python manage.py migrate && gunicorn config.wsgi",
    "healthcheckPath": "/api/health/"
  }
}
EOF

# Update requirements.txt
echo "gunicorn>=21.0.0" >> requirements.txt
```

#### 2. Environment Variables for Railway
```bash
# Set in Railway dashboard
DEBUG=False
SECRET_KEY=your-secret-key-here
ALLOWED_HOSTS=*.up.railway.app
CORS_ALLOWED_ORIGINS=https://your-app.vercel.app
DATABASE_URL=postgresql://... # Auto-provided by Railway
```

#### 3. Prepare Frontend for Vercel
```bash
cd apps/web

# Create vercel.json
cat > vercel.json << EOF
{
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "out"
      }
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
EOF

# Update package.json scripts
npm pkg set scripts.build="next build && next export"
```

#### 4. Environment Variables for Vercel
```bash
# Set in Vercel dashboard
NEXT_PUBLIC_API_URL=https://your-backend.up.railway.app
```

### Alternative: Render.com (Another Free Option)

#### Backend on Render (Free)
- 750 hours/month free
- Spins down after 15 minutes of inactivity
- PostgreSQL database included

#### Setup:
1. Connect GitHub repo to Render
2. Select "Web Service" 
3. Build command: `pip install -r requirements.txt`
4. Start command: `gunicorn config.wsgi`

### Cost Comparison

| Service | Free Tier | Paid Tier | Monthly Cost |
|---------|-----------|-----------|--------------|
| Railway | 500hrs execution | Unlimited | $0 - $5 |
| Vercel | 100GB bandwidth | Unlimited | $0 |
| Render | 750hrs/month | Unlimited | $0 - $7 |
| **Total** | **$0/month** | **$5/month** |

### Mobile App Distribution

#### Development (Free)
- Use Expo Go app
- Share via QR codes
- Unlimited development builds

#### Production Apps
**Option A: Expo Application Services (EAS)**
- Free tier: 30 builds/month
- Paid: $29/month for unlimited

**Option B: Self-hosted builds (Free)**
```bash
# Build locally (requires setup)
cd apps/mobile
expo build:android --type apk
expo build:ios --type archive
```

### Performance Optimizations

#### Backend Optimizations
```python
# In settings.py - Add caching
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.redis.RedisCache',
        'LOCATION': 'redis://localhost:6379/1',
    }
}

# Static file compression
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
```

#### Frontend Optimizations
```javascript
// next.config.js
module.exports = {
  output: 'export',
  images: {
    unoptimized: true
  },
  experimental: {
    optimizeCss: true
  }
}
```

---

## Troubleshooting

### Common Issues

#### Backend Issues
```bash
# Port already in use
lsof -ti:8000 | xargs kill -9

# Database issues
cd backend
python manage.py migrate --run-syncdb

# Permission issues (Windows)
python -m pip install --user -r requirements.txt
```

#### Frontend Issues  
```bash
# Clear Next.js cache
cd apps/web
rm -rf .next
npm run dev

# Node modules issues
rm -rf node_modules package-lock.json
npm install
```

#### Mobile App Issues
```bash
# Clear Expo cache
cd apps/mobile
expo r -c

# Metro bundler issues
npx react-native start --reset-cache

# Network issues
# Ensure phone and computer on same WiFi
# Check firewall settings
```

#### Android Specific
- **App won't load**: Check WiFi connection, try USB debugging
- **Performance slow**: Enable "Fast Refresh" in Expo Go settings
- **Crashes**: Check terminal logs for error messages

#### iPad Specific  
- **Layout issues**: Test in both orientations
- **Touch not working**: Ensure touch targets are 44pt minimum
- **Text too small**: Increase font sizes in styles

### Debugging Commands

#### Check Service Status
```bash
# Backend health
curl http://localhost:8000/api/health/

# Frontend build
cd apps/web && npm run build

# Mobile app logs
cd apps/mobile && expo logs
```

#### View Logs
```bash
# Django logs
cd backend && python manage.py runserver --verbosity=2

# Next.js logs  
cd apps/web && npm run dev

# Expo logs
cd apps/mobile && expo start --clear
```

### Getting Help

1. **Check logs** in terminal where services are running
2. **Clear caches** using commands above  
3. **Restart services** in correct order (backend → frontend → mobile)
4. **Check network connectivity** for mobile app
5. **Verify environment variables** are set correctly

---

## Summary

### Development URLs
- **Backend API**: http://localhost:8000
- **Web App**: http://localhost:3000  
- **Mobile App**: Expo Go app via QR code

### Production Deployment
- **Total Cost**: $0-5/month
- **Backend**: Railway.app
- **Frontend**: Vercel  
- **Mobile**: Expo Go (development) / App stores (production)

### Quick Start Commands
```bash
# Terminal 1: Backend
cd backend && source venv/bin/activate && python manage.py runserver

# Terminal 2: Web  
cd apps/web && npm run dev

# Terminal 3: Mobile
cd apps/mobile && npm start
```

The setup is now optimized for minimal cost while maintaining full functionality across web, Android, and iPad platforms!