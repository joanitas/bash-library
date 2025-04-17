#!/bin/bash

# Example script using aws-secrets.sh as a sourced library
# This script demonstrates how to use the AWS secrets functions directly

# Set AWS credentials (if needed)
export AWS_PROFILE="my-profile"
export AWS_REGION="us-east-1"

# Source the bash library
LIB_DIR="/path/to/bash-library"
# shellcheck disable=SC1091
source "$LIB_DIR/lib-loader.sh"

# Example 1: Get entire secret
echo "Getting database credentials..."
if ! DB_CREDS=$(lib_aws_get_secret "prod/database/credentials"); then
    lib_log_error "Failed to get database credentials"
    exit 1
fi
lib_log_info "Database credentials retrieved successfully"

# Example 2: Get specific value
echo "Getting database password..."
if ! DB_PASSWORD=$(lib_aws_get_secret_value "prod/database/credentials" "password"); then
    lib_log_error "Failed to get database password"
    exit 1
fi
lib_log_info "Database password retrieved successfully"
echo "Password length: ${#DB_PASSWORD} characters"  # Example usage of DB_PASSWORD

# Example 3: Using in a function
function connect_to_database() {
    local secret_name="$1"
    local db_host="$2"
    
    lib_log_info "Connecting to database using secret: $secret_name"
    
    # Get database credentials
    if ! DB_CREDS=$(lib_aws_get_secret "$secret_name"); then
        lib_log_error "Failed to get database credentials"
        return 1
    fi
    
    # Extract values
    local username
    local password
    username=$(echo "$DB_CREDS" | jq -r '.username')
    password=$(echo "$DB_CREDS" | jq -r '.password')
    
    # Connect to database
    if ! mysql -h "$db_host" -u "$username" -p"$password" -e "SHOW DATABASES"; then
        lib_log_error "Failed to connect to database"
        return 1
    fi
    
    lib_log_info "Successfully connected to database"
    return 0
}

# Example 4: Using the function
if ! connect_to_database "prod/database/credentials" "db.example.com"; then
    exit 1
fi

# Example 5: Error handling with logging
function safe_secret_operation() {
    local operation="$1"
    local secret_name="$2"
    local value="${3:-}"
    
    lib_log_info "Performing $operation on secret: $secret_name"
    
    case "$operation" in
        "get")
            if ! lib_aws_get_secret "$secret_name"; then
                lib_log_error "Failed to get secret"
                return 1
            fi
            ;;
        "get-value")
            if ! lib_aws_get_secret_value "$secret_name" "$value"; then
                lib_log_error "Failed to get secret value"
                return 1
            fi
            ;;
        *)
            lib_log_error "Invalid operation: $operation"
            return 1
            ;;
    esac
    
    lib_log_info "Operation completed successfully"
    return 0
}

# Use the safe operation function
if ! safe_secret_operation "get-value" "prod/database/credentials" "password"; then
    exit 1
fi 