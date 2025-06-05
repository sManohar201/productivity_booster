# Azure Deployment Guide - Using Free Credits

## Azure Free Credits Overview

### Azure Free Account Benefits
- **$200 credit** for first 30 days
- **12 months free services** (limited quantities)
- **Always free services** (with usage limits)

### Recommended Azure Architecture for Free Credits

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │     Backend      │    │    Database     │
│                 │    │                  │    │                 │
│ Azure Static    │◄──►│ Azure App        │◄──►│ Azure SQL       │
│ Web Apps        │    │ Service          │    │ Database        │
│ (Free)          │    │ (Free/B1 tier)   │    │ (Free tier)     │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

## Step-by-Step Azure Deployment

### Prerequisites
```bash
# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to Azure
az login

# Set subscription (if you have multiple)
az account set --subscription "your-subscription-id"
```

### 1. Create Resource Group
```bash
# Create resource group in a free tier region
az group create \
  --name productivity-booster-rg \
  --location "East US"
```

### 2. Deploy Backend (Django API)

#### Option A: App Service Free Tier (F1)
```bash
# Create App Service Plan (Free tier)
az appservice plan create \
  --name productivity-booster-plan \
  --resource-group productivity-booster-rg \
  --sku F1 \
  --is-linux

# Create Web App
az webapp create \
  --resource-group productivity-booster-rg \
  --plan productivity-booster-plan \
  --name productivity-booster-api \
  --runtime "PYTHON|3.11" \
  --deployment-local-git
```

**Free Tier F1 Limits:**
- 1GB RAM
- 1GB storage  
- 60 CPU minutes/day
- Custom domain not included

#### Option B: App Service Basic (B1) - Recommended
```bash
# Create App Service Plan (Basic B1 - uses credits)
az appservice plan create \
  --name productivity-booster-plan \
  --resource-group productivity-booster-rg \
  --sku B1 \
  --is-linux

# Create Web App  
az webapp create \
  --resource-group productivity-booster-rg \
  --plan productivity-booster-plan \
  --name productivity-booster-api \
  --runtime "PYTHON|3.11"
```

**Basic B1 Benefits (Cost: ~$13/month, covered by credits):**
- 1.75GB RAM
- 10GB storage
- Unlimited CPU time
- Custom domains included
- SSL certificates

#### Configure App Settings
```bash
# Set Django environment variables
az webapp config appsettings set \
  --resource-group productivity-booster-rg \
  --name productivity-booster-api \
  --settings \
    DJANGO_SETTINGS_MODULE="config.settings" \
    DEBUG="False" \
    SECRET_KEY="$(openssl rand -base64 32)" \
    ALLOWED_HOSTS="productivity-booster-api.azurewebsites.net" \
    SCM_DO_BUILD_DURING_DEPLOYMENT="true" \
    ENABLE_ORYX_BUILD="true"
```

### 3. Database Setup

#### Option A: Azure SQL Database (Free)
```bash
# Create SQL Server
az sql server create \
  --name productivity-booster-sql \
  --resource-group productivity-booster-rg \
  --location "East US" \
  --admin-user dbadmin \
  --admin-password "SecurePassword123!"

# Create database (Free tier - 32MB)
az sql db create \
  --resource-group productivity-booster-rg \
  --server productivity-booster-sql \
  --name productivity-booster-db \
  --edition Basic \
  --capacity 5

# Configure firewall for Azure services
az sql server firewall-rule create \
  --resource-group productivity-booster-rg \
  --server productivity-booster-sql \
  --name AllowAzureServices \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0
```

#### Option B: PostgreSQL Flexible Server (Recommended)
```bash
# Create PostgreSQL server (Burstable B1ms - ~$12/month)
az postgres flexible-server create \
  --resource-group productivity-booster-rg \
  --name productivity-booster-pg \
  --location "East US" \
  --admin-user dbadmin \
  --admin-password "SecurePassword123!" \
  --sku-name Standard_B1ms \
  --tier Burstable \
  --storage-size 32

# Create database
az postgres flexible-server db create \
  --resource-group productivity-booster-rg \
  --server-name productivity-booster-pg \
  --database-name productivity_booster

# Configure firewall
az postgres flexible-server firewall-rule create \
  --resource-group productivity-booster-rg \
  --name productivity-booster-pg \
  --rule-name AllowAzureServices \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0
```

### 4. Frontend Deployment (Static Web Apps)

#### Create Static Web App (Free)
```bash
# Create static web app
az staticwebapp create \
  --name productivity-booster-web \
  --resource-group productivity-booster-rg \
  --source https://github.com/yourusername/productivity-booster \
  --branch main \
  --app-location "/apps/web" \
  --output-location "out" \
  --login-with-github
```

**Static Web Apps Free Tier:**
- 100GB bandwidth/month
- Custom domains
- SSL certificates
- Global CDN
- Staging environments

### 5. Configure CI/CD with GitHub Actions

#### Update GitHub Secrets
```bash
# Get Azure credentials for GitHub Actions
az ad sp create-for-rbac --name "productivity-booster-sp" --role contributor \
  --scopes /subscriptions/{subscription-id}/resourceGroups/productivity-booster-rg \
  --sdk-auth
```

Add these secrets to your GitHub repository:
- `AZURE_CREDENTIALS`: Output from above command
- `AZURE_WEBAPP_NAME`: productivity-booster-api
- `AZURE_WEBAPP_PUBLISH_PROFILE`: Download from Azure Portal

#### Enhanced Azure Deployment Workflow

The GitHub Actions workflow (`.github/workflows/deploy-azure.yml`) handles:
- Automated testing
- Backend deployment to App Service
- Frontend deployment to Static Web Apps
- Database migrations
- Mobile app testing

### 6. Environment Configuration

#### Backend Environment Variables (Azure App Service)
```bash
# Set all required environment variables
az webapp config appsettings set \
  --resource-group productivity-booster-rg \
  --name productivity-booster-api \
  --settings \
    DEBUG="False" \
    SECRET_KEY="your-secret-key-here" \
    ALLOWED_HOSTS="productivity-booster-api.azurewebsites.net,productivity-booster-web.azurestaticapps.net" \
    CORS_ALLOWED_ORIGINS="https://productivity-booster-web.azurestaticapps.net" \
    DATABASE_URL="postgresql://dbadmin:SecurePassword123!@productivity-booster-pg.postgres.database.azure.com/productivity_booster" \
    DJANGO_SETTINGS_MODULE="config.settings" \
    SCM_DO_BUILD_DURING_DEPLOYMENT="true"
```

#### Frontend Environment Variables (Static Web Apps)
Configure in Azure Portal → Static Web Apps → Configuration:
```
NEXT_PUBLIC_API_URL=https://productivity-booster-api.azurewebsites.net
```

### 7. GitHub Repository Secrets

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

```bash
# Azure credentials for deployment
AZURE_CREDENTIALS='{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "...",
  "tenantId": "..."
}'

# Django secret key
DJANGO_SECRET_KEY="your-generated-secret-key"

# Database connection
DATABASE_URL="postgresql://dbadmin:SecurePassword123!@productivity-booster-pg.postgres.database.azure.com/productivity_booster"

# Azure Static Web Apps deployment token
AZURE_STATIC_WEB_APPS_API_TOKEN="your-static-web-apps-token"

# Azure Web App publish profile (download from portal)
AZURE_WEBAPP_PUBLISH_PROFILE="<publishData>...</publishData>"
```

## Cost Analysis with Azure Credits

### Monthly Costs (Covered by $200 credit)

| Service | Tier | Monthly Cost | Description |
|---------|------|-------------|-------------|
| **App Service** | B1 Basic | $13.14 | Backend API hosting |
| **PostgreSQL** | B1ms Burstable | $12.41 | Database server |
| **Static Web Apps** | Free | $0.00 | Frontend hosting |
| **Application Insights** | Free | $0.00 | Monitoring & logs |
| **Storage Account** | LRS | $2.00 | Static files storage |
| **Total** | | **$27.55** | **7.2 months** with $200 credit |

### Free Tier Alternative (12 months free)

| Service | Tier | Monthly Cost | Description |
|---------|------|-------------|-------------|
| **App Service** | F1 Free | $0.00 | 60 CPU minutes/day limit |
| **SQL Database** | Free | $0.00 | 32MB storage limit |
| **Static Web Apps** | Free | $0.00 | Frontend hosting |
| **Total** | | **$0.00** | **Free for 12 months** |

## Optimization for Azure Credits

### 1. Use Azure Free Services
```bash
# Configure free tier services where possible
# App Service F1 for development/testing
az appservice plan create \
  --name productivity-booster-plan-free \
  --resource-group productivity-booster-rg \
  --sku F1

# SQL Database free tier
az sql db create \
  --resource-group productivity-booster-rg \
  --server productivity-booster-sql \
  --name productivity-booster-db \
  --edition Free
```

### 2. Auto-shutdown for Development
```bash
# Create automation account for auto-shutdown
az automation account create \
  --name productivity-booster-automation \
  --resource-group productivity-booster-rg \
  --location "East US"

# Schedule to stop App Service during non-business hours
# Saves ~60% on compute costs
```

### 3. Monitoring & Alerts
```bash
# Set up budget alerts
az consumption budget create \
  --account-id "/subscriptions/{subscription-id}" \
  --budget-name "ProductivityBoosterBudget" \
  --amount 50 \
  --time-grain Monthly \
  --time-period start-date="2024-01-01" \
  --category Cost
```

## Deployment Steps

### 1. Prepare Repository
```bash
# Ensure all optimization files are in place
git add .
git commit -m "Add Azure deployment configuration"
git push origin main
```

### 2. Create Azure Resources
```bash
# Run the deployment script
./scripts/deploy-azure.sh

# Or manually execute Azure CLI commands above
```

### 3. Configure GitHub Actions
1. Fork/clone repository
2. Add GitHub secrets (listed above)
3. Push to main branch
4. GitHub Actions will automatically deploy

### 4. Verify Deployment
```bash
# Test backend API
curl https://productivity-booster-api.azurewebsites.net/api/health/

# Test frontend
curl https://productivity-booster-web.azurestaticapps.net

# Check logs
az webapp log tail --name productivity-booster-api --resource-group productivity-booster-rg
```

## Scaling Strategy

### Development Phase (Free Tier)
- App Service F1 (Free)
- SQL Database Free (32MB)
- Static Web Apps (Free)
- **Cost**: $0/month

### Production Phase (Basic Tier)
- App Service B1 ($13/month)
- PostgreSQL B1ms ($12/month) 
- Static Web Apps (Free)
- **Cost**: $25/month (covered by credits)

### High Traffic Phase
- App Service S1 ($74/month)
- PostgreSQL General Purpose ($100/month)
- CDN Premium ($10/month)
- **Cost**: $184/month

## Monitoring & Maintenance

### Application Insights Setup
```bash
# Enable Application Insights
az monitor app-insights component create \
  --app productivity-booster-insights \
  --location "East US" \
  --resource-group productivity-booster-rg \
  --application-type web
```

### Log Analytics
```bash
# View live logs
az webapp log tail \
  --name productivity-booster-api \
  --resource-group productivity-booster-rg

# Download logs
az webapp log download \
  --name productivity-booster-api \
  --resource-group productivity-booster-rg
```

### Performance Monitoring
- **Response time**: Target < 2 seconds
- **Availability**: Target > 99.9%
- **Error rate**: Target < 1%
- **Database queries**: Monitor slow queries

## Troubleshooting

### Common Azure Issues
```bash
# App Service won't start
az webapp log tail --name productivity-booster-api --resource-group productivity-booster-rg

# Database connection issues
az postgres flexible-server show-connection-string \
  --server-name productivity-booster-pg \
  --database-name productivity_booster

# Static Web Apps build failures
# Check GitHub Actions logs in repository
```

### Debug Commands
```bash
# SSH into App Service (if enabled)
az webapp ssh --name productivity-booster-api --resource-group productivity-booster-rg

# Restart services
az webapp restart --name productivity-booster-api --resource-group productivity-booster-rg

# View metrics
az monitor metrics list \
  --resource /subscriptions/{sub-id}/resourceGroups/productivity-booster-rg/providers/Microsoft.Web/sites/productivity-booster-api \
  --metric-names CpuTime,Requests,ResponseTime
```

## Summary

Your Azure deployment will provide:
- **Professional hosting** with custom domains and SSL
- **Scalable architecture** that grows with your app
- **Integrated monitoring** and logging
- **CI/CD pipeline** for automatic deployments
- **Cost-effective** usage of your Azure credits
- **Production-ready** setup for web, mobile, and API

The $200 Azure credit will cover approximately **7+ months** of production hosting, giving you plenty of time to develop and test your productivity application!