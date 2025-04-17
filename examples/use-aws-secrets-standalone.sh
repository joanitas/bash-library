#!/bin/bash

# Example script using aws-secrets.sh as a standalone command
# This script demonstrates how to manage database credentials using aws-secrets.sh

# Set AWS credentials (if needed)
export AWS_PROFILE="my-profile"
export AWS_REGION="us-east-1"

# Path to the aws-secrets.sh script
AWS_SECRETS_SCRIPT="/path/to/bash-library/scripts/aws-secrets.sh"

# Example 1: Get entire secret
echo "Getting database credentials..."
if ! DB_CREDS=$("$AWS_SECRETS_SCRIPT" get "prod/database/credentials"); then
    echo "Failed to get database credentials"
    exit 1
fi
echo "Database credentials: $DB_CREDS"

# Example 2: Get specific value
echo "Getting database password..."
if ! DB_PASSWORD=$("$AWS_SECRETS_SCRIPT" get-value "prod/database/credentials" "password"); then
    echo "Failed to get database password"
    exit 1
fi
echo "Database password retrieved successfully"

# Example 3: Rotate secret
echo "Rotating database credentials..."
NEW_CREDS='{"username":"newuser","password":"newpass123"}'
if ! "$AWS_SECRETS_SCRIPT" rotate "prod/database/credentials" "$NEW_CREDS"; then
    echo "Failed to rotate credentials"
    exit 1
fi
echo "Credentials rotated successfully"

# Example 4: Using in a pipeline
echo "Using secret in a pipeline..."
if ! "$AWS_SECRETS_SCRIPT" get-value "prod/database/credentials" "password" | \
    mysql -u root -p"$DB_PASSWORD" -e "SHOW DATABASES"; then
    echo "Failed to connect to database"
    exit 1
fi
echo "Successfully connected to database" 