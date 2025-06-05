#!/bin/bash

# Azure Deployment Script for Productivity Booster
# This script automates the Azure resource creation and deployment

set -e  # Exit on any error

# Configuration
RESOURCE_GROUP="productivity-booster-rg"
LOCATION="eastus"
APP_SERVICE_PLAN="productivity-booster-plan"
WEBAPP_NAME="productivity-booster-api"
DB_SERVER_NAME="productivity-booster-pg"
DB_NAME="productivity_booster"
STATIC_WEB_APP="productivity-booster-web"
DB_ADMIN_USER="dbadmin"
DB_ADMIN_PASSWORD="SecurePassword$(date +%s)!" # Generate unique password

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

echo_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo_error "Azure CLI is not installed. Please install it first."
    echo_info "Visit: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

# Check if user is logged in
if ! az account show &> /dev/null; then
    echo_warn "You are not logged into Azure. Please login first."
    az login
fi

echo_info "Starting Azure deployment for Productivity Booster..."

# Step 1: Create Resource Group
echo_info "Creating resource group: $RESOURCE_GROUP"
az group create \
    --name $RESOURCE_GROUP \
    --location $LOCATION \
    --output table

# Step 2: Create App Service Plan
echo_info "Creating App Service Plan: $APP_SERVICE_PLAN"
az appservice plan create \
    --name $APP_SERVICE_PLAN \
    --resource-group $RESOURCE_GROUP \
    --sku B1 \
    --is-linux \
    --output table

# Step 3: Create Web App
echo_info "Creating Web App: $WEBAPP_NAME"
az webapp create \
    --resource-group $RESOURCE_GROUP \
    --plan $APP_SERVICE_PLAN \
    --name $WEBAPP_NAME \
    --runtime "PYTHON|3.11" \
    --output table

# Step 4: Create PostgreSQL Server
echo_info "Creating PostgreSQL server: $DB_SERVER_NAME"
echo_warn "Database password: $DB_ADMIN_PASSWORD"
az postgres flexible-server create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --location $LOCATION \
    --admin-user $DB_ADMIN_USER \
    --admin-password "$DB_ADMIN_PASSWORD" \
    --sku-name Standard_B1ms \
    --tier Burstable \
    --storage-size 32 \
    --output table

# Step 5: Create Database
echo_info "Creating database: $DB_NAME"
az postgres flexible-server db create \
    --resource-group $RESOURCE_GROUP \
    --server-name $DB_SERVER_NAME \
    --database-name $DB_NAME \
    --output table

# Step 6: Configure PostgreSQL Firewall
echo_info "Configuring PostgreSQL firewall rules"
az postgres flexible-server firewall-rule create \
    --resource-group $RESOURCE_GROUP \
    --name $DB_SERVER_NAME \
    --rule-name AllowAzureServices \
    --start-ip-address 0.0.0.0 \
    --end-ip-address 0.0.0.0 \
    --output table

# Step 7: Configure App Service Settings
echo_info "Configuring App Service environment variables"

# Generate Django secret key
DJANGO_SECRET_KEY=$(openssl rand -base64 32)

DATABASE_URL="postgresql://$DB_ADMIN_USER:$DB_ADMIN_PASSWORD@$DB_SERVER_NAME.postgres.database.azure.com/$DB_NAME"

az webapp config appsettings set \
    --resource-group $RESOURCE_GROUP \
    --name $WEBAPP_NAME \
    --settings \
        DJANGO_SETTINGS_MODULE="config.settings" \
        DEBUG="False" \
        SECRET_KEY="$DJANGO_SECRET_KEY" \
        ALLOWED_HOSTS="$WEBAPP_NAME.azurewebsites.net" \
        DATABASE_URL="$DATABASE_URL" \
        CORS_ALLOWED_ORIGINS="https://$STATIC_WEB_APP.azurestaticapps.net" \
        SCM_DO_BUILD_DURING_DEPLOYMENT="true" \
        ENABLE_ORYX_BUILD="true" \
    --output table

# Step 8: Enable App Service Logs
echo_info "Enabling App Service logging"
az webapp log config \
    --resource-group $RESOURCE_GROUP \
    --name $WEBAPP_NAME \
    --application-logging filesystem \
    --detailed-error-messages true \
    --failed-request-tracing true \
    --web-server-logging filesystem \
    --output table

# Step 9: Create Static Web App (requires GitHub repository)
echo_warn "Static Web App creation requires GitHub repository URL"
echo_info "Please create Static Web App manually in Azure Portal or provide GitHub repo URL"

# Get publish profile for GitHub Actions
echo_info "Getting publish profile for GitHub Actions"
PUBLISH_PROFILE=$(az webapp deployment list-publishing-profiles \
    --resource-group $RESOURCE_GROUP \
    --name $WEBAPP_NAME \
    --xml)

# Create deployment summary file
cat > deployment-summary.txt << EOF
Azure Deployment Summary
========================

Resource Group: $RESOURCE_GROUP
Location: $LOCATION

Services Created:
-----------------
✅ App Service Plan: $APP_SERVICE_PLAN (B1 Basic - ~\$13/month)
✅ Web App: $WEBAPP_NAME.azurewebsites.net
✅ PostgreSQL Server: $DB_SERVER_NAME.postgres.database.azure.com
✅ Database: $DB_NAME

Important Information:
----------------------
Database Admin User: $DB_ADMIN_USER
Database Admin Password: $DB_ADMIN_PASSWORD
Django Secret Key: $DJANGO_SECRET_KEY
Database URL: $DATABASE_URL

GitHub Secrets to Add:
----------------------
DJANGO_SECRET_KEY="$DJANGO_SECRET_KEY"
DATABASE_URL="$DATABASE_URL"
AZURE_WEBAPP_PUBLISH_PROFILE="[Download from Azure Portal]"

Next Steps:
-----------
1. Add GitHub repository secrets
2. Create Static Web App for frontend
3. Push code to trigger deployment
4. Run database migrations

URLs:
-----
Backend API: https://$WEBAPP_NAME.azurewebsites.net
Health Check: https://$WEBAPP_NAME.azurewebsites.net/api/health/

Estimated Monthly Cost: ~\$25-30 (covered by Azure credits)
EOF

echo_info "Deployment completed successfully!"
echo_info "Summary saved to: deployment-summary.txt"
echo_info ""
echo_info "Next steps:"
echo_info "1. Add the GitHub secrets listed in deployment-summary.txt"
echo_info "2. Create Azure Static Web App for frontend"
echo_info "3. Push your code to trigger automatic deployment"
echo_info ""
echo_info "Backend URL: https://$WEBAPP_NAME.azurewebsites.net"
echo_warn "Important: Save the database password from deployment-summary.txt"

# Show cost estimation
echo_info ""
echo_info "💰 Cost Estimation:"
echo_info "   App Service B1: ~\$13/month"
echo_info "   PostgreSQL B1ms: ~\$12/month"
echo_info "   Static Web Apps: Free"
echo_info "   Total: ~\$25/month (7+ months with \$200 credit)"

echo_info ""
echo_info "🎉 Azure deployment completed successfully!"