# Quick Start: Azure Deployment with Free Credits

## TL;DR - One-Command Deployment

```bash
# Clone and deploy in 5 minutes
git clone <your-repo>
cd productivity-booster
./scripts/deploy-azure.sh
```

## What You Get

### ✅ **Professional Azure Setup**
- **Backend**: Django API on Azure App Service (B1 tier)
- **Frontend**: Next.js on Azure Static Web Apps (Free)
- **Database**: PostgreSQL Flexible Server (B1ms)
- **CI/CD**: GitHub Actions auto-deployment
- **Monitoring**: Application Insights included

### 💰 **Cost with Free Credits**
- **Monthly cost**: ~$25 (App Service $13 + PostgreSQL $12)
- **Duration**: **7+ months** with $200 Azure credit
- **Free tier option**: $0/month (with limitations)

## Step-by-Step Setup

### 1. Prerequisites (2 minutes)
```bash
# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login to Azure
az login

# Verify subscription
az account show
```

### 2. Deploy Infrastructure (3 minutes)
```bash
# Run automated deployment
cd productivity-booster
chmod +x scripts/deploy-azure.sh
./scripts/deploy-azure.sh
```

**Script creates:**
- Resource group
- App Service + plan
- PostgreSQL database
- Firewall rules
- Environment variables

### 3. Configure GitHub (2 minutes)

Add these secrets to your GitHub repository (Settings → Secrets):

```bash
# From deployment-summary.txt file
DJANGO_SECRET_KEY="your-generated-secret-key"
DATABASE_URL="postgresql://..."
AZURE_WEBAPP_PUBLISH_PROFILE="<download-from-portal>"
```

### 4. Create Static Web App (2 minutes)

**Option A: Azure Portal (GUI)**
1. Go to Azure Portal → Create Resource
2. Search "Static Web Apps" → Create
3. Connect to your GitHub repository
4. Set build details:
   - App location: `/apps/web`
   - Output location: `out`

**Option B: Azure CLI**
```bash
az staticwebapp create \
  --name productivity-booster-web \
  --resource-group productivity-booster-rg \
  --source https://github.com/yourusername/productivity-booster \
  --branch main \
  --app-location "/apps/web" \
  --output-location "out"
```

### 5. Deploy Code (1 minute)
```bash
# Push to trigger deployment
git add .
git commit -m "Deploy to Azure"
git push origin main

# GitHub Actions will automatically deploy
# Check: https://github.com/yourusername/repo/actions
```

## Verification & Testing

### Backend API
```bash
# Health check
curl https://productivity-booster-api.azurewebsites.net/api/health/

# Should return: {"status": "healthy", "message": "..."}
```

### Frontend Web App
```bash
# Test web app
curl https://productivity-booster-web.azurestaticapps.net

# Open in browser to see full UI
```

### Mobile App
```bash
# Update mobile app config
cd apps/mobile
# Update API_URL in your app.json or config to point to Azure backend
npm start
# Test on device via Expo Go
```

## Production URLs

After deployment, your apps will be available at:

- **Backend API**: `https://productivity-booster-api.azurewebsites.net`
- **Web App**: `https://productivity-booster-web.azurestaticapps.net`
- **Mobile**: Via Expo Go app (scan QR code)

## Cost Optimization Tips

### Free Tier Option (Zero Cost)
```bash
# Downgrade to free tier if needed
az appservice plan update \
  --name productivity-booster-plan \
  --resource-group productivity-booster-rg \
  --sku F1

# Use SQL Database free tier (32MB limit)
# Static Web Apps remain free
```

### Auto-shutdown (60% cost savings)
```bash
# Stop App Service during off-hours
az webapp stop --name productivity-booster-api --resource-group productivity-booster-rg

# Start when needed
az webapp start --name productivity-booster-api --resource-group productivity-booster-rg
```

### Monitoring Costs
```bash
# Set up budget alert
az consumption budget create \
  --budget-name "ProductivityBudget" \
  --amount 30 \
  --time-grain Monthly

# Check current usage
az consumption usage list --top 10
```

## Scaling Options

### Development → Production
| Stage | App Service | Database | Monthly Cost |
|-------|-------------|----------|--------------|
| **Development** | F1 (Free) | Free (32MB) | $0 |
| **MVP** | B1 (Basic) | B1ms (Burstable) | $25 |
| **Production** | S1 (Standard) | GP_Gen5_2 | $174 |

### Traffic-based Scaling
- **< 1000 users/day**: B1 Basic ($25/month)
- **< 10,000 users/day**: S1 Standard ($74/month)  
- **> 10,000 users/day**: P1V2 Premium ($146/month)

## Troubleshooting

### Common Issues
```bash
# App won't start
az webapp log tail --name productivity-booster-api --resource-group productivity-booster-rg

# Database connection failed
az postgres flexible-server show-connection-string --server-name productivity-booster-pg

# GitHub Actions failing
# Check logs in GitHub repository → Actions tab

# Static Web App not updating
# Verify GitHub integration in Azure Portal
```

### Reset Deployment
```bash
# Delete and recreate if needed
az group delete --name productivity-booster-rg --yes
./scripts/deploy-azure.sh
```

## Advanced Configuration

### Custom Domains (Optional)
```bash
# Add custom domain to App Service
az webapp config hostname add \
  --resource-group productivity-booster-rg \
  --webapp-name productivity-booster-api \
  --hostname api.yourdomain.com

# Add custom domain to Static Web App
az staticwebapp hostname set \
  --name productivity-booster-web \
  --hostname app.yourdomain.com
```

### SSL Certificates (Automatic)
- Azure automatically provides SSL certificates
- No additional configuration needed
- Certificates auto-renew

### Application Insights (Monitoring)
```bash
# Enable detailed monitoring
az monitor app-insights component create \
  --app productivity-booster-insights \
  --location eastus \
  --resource-group productivity-booster-rg
```

## Summary

Your Azure deployment provides:

✅ **Enterprise-grade hosting** with 99.9% SLA  
✅ **Automatic scaling** based on traffic  
✅ **Global CDN** for fast content delivery  
✅ **SSL certificates** and custom domains  
✅ **Integrated monitoring** and logging  
✅ **CI/CD pipeline** with GitHub Actions  
✅ **7+ months** of hosting with $200 Azure credit  

Perfect for testing your productivity application with real users while leveraging your Azure free credits!