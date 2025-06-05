# Azure Deployment Guide

## Prerequisites

1. Azure subscription
2. Azure CLI installed locally
3. GitHub repository with secrets configured

## Backend Deployment (Django API)

### 1. Create Azure App Service
```bash
# Create resource group
az group create --name productivity-booster-rg --location "East US"

# Create App Service plan
az appservice plan create --name productivity-booster-plan --resource-group productivity-booster-rg --sku B1 --is-linux

# Create web app
az webapp create --resource-group productivity-booster-rg --plan productivity-booster-plan --name productivity-booster-api --runtime "PYTHON|3.11" --deployment-local-git
```

### 2. Configure App Settings
```bash
# Set environment variables
az webapp config appsettings set --resource-group productivity-booster-rg --name productivity-booster-api --settings \
  DJANGO_SETTINGS_MODULE="config.settings" \
  DEBUG="False" \
  SECRET_KEY="your-production-secret-key" \
  ALLOWED_HOSTS="productivity-booster-api.azurewebsites.net" \
  DATABASE_URL="your-postgres-connection-string"
```

### 3. GitHub Secrets Required
- `AZURE_BACKEND_APP_NAME`: productivity-booster-api
- `AZURE_BACKEND_PUBLISH_PROFILE`: Download from Azure Portal

## Frontend Deployment (Next.js Web App)

### 1. Create Azure Static Web App
```bash
# Create static web app
az staticwebapp create --name productivity-booster-web --resource-group productivity-booster-rg --source https://github.com/yourusername/productivity-booster --branch main --app-location "/apps/web" --output-location "out"
```

### 2. GitHub Secrets Required
- `AZURE_STATIC_WEB_APPS_API_TOKEN`: From Azure Static Web Apps
- `NEXT_PUBLIC_API_URL`: https://productivity-booster-api.azurewebsites.net

## Database Setup

### 1. Create PostgreSQL Database
```bash
# Create PostgreSQL server
az postgres server create --resource-group productivity-booster-rg --name productivity-booster-db --location "East US" --admin-user dbadmin --admin-password "SecurePassword123!" --sku-name GP_Gen5_2

# Create database
az postgres db create --resource-group productivity-booster-rg --server-name productivity-booster-db --name productivity_booster

# Configure firewall (allow Azure services)
az postgres server firewall-rule create --resource-group productivity-booster-rg --server productivity-booster-db --name AllowAzureServices --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
```

## Mobile App Deployment

### Expo Setup
1. Create Expo account at https://expo.dev
2. Install Expo CLI: `npm install -g @expo/cli`
3. Login: `expo login`

### GitHub Secrets for Mobile
- `EXPO_TOKEN`: From Expo CLI (`expo whoami --auth`)
- `EXPO_APPLE_ID`: Apple developer account email
- `EXPO_APPLE_PASSWORD`: App-specific password

### Deployment Options

#### Option 1: Expo Go (Development)
- Push updates via `expo publish`
- Users scan QR code with Expo Go app

#### Option 2: Standalone Apps (Production)
- Build APK/IPA files
- Distribute via Google Play Store / App Store
- Use Expo Application Services (EAS) for automated builds

## Cost Estimation (Monthly)

- Azure App Service (B1): ~$13/month
- Azure Static Web Apps: Free tier available
- PostgreSQL (GP_Gen5_2): ~$100/month
- Azure Storage: ~$5/month

**Total: ~$118/month for production environment**

## Environment Variables Summary

### Backend (.env)
```
DEBUG=False
SECRET_KEY=your-production-secret-key
DATABASE_URL=postgresql://dbadmin:SecurePassword123!@productivity-booster-db.postgres.database.azure.com/productivity_booster
ALLOWED_HOSTS=productivity-booster-api.azurewebsites.net
CORS_ALLOWED_ORIGINS=https://productivity-booster-web.azurestaticapps.net
```

### Frontend (.env.local)
```
NEXT_PUBLIC_API_URL=https://productivity-booster-api.azurewebsites.net
```