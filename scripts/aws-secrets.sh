#!/bin/bash

# AWS Secrets Management Script
# Version: 1.0.0
# Description: Script for managing AWS secrets with complex operations

# Source the library
LIB_DIR="$(dirname "${BASH_SOURCE[0]}")/.."
# shellcheck disable=SC1091
source "$LIB_DIR/lib-loader.sh"

# Function: validate_secret_name
# Description: Validates the format of a secret name
# Usage: validate_secret_name "secret-name"
validate_secret_name() {
    local secret_name="$1"
    if [[ ! "$secret_name" =~ ^[a-zA-Z0-9/_+=.@-]+$ ]]; then
        lib_log_error "Invalid secret name format: $secret_name"
        return 1
    fi
    return 0
}

# Function: rotate_secret
# Description: Rotates a secret value
# Usage: rotate_secret "secret-name" "new-value"
rotate_secret() {
    local secret_name="$1"
    local new_value="$2"
    local aws_profile="${AWS_PROFILE:-}"
    local aws_region="${AWS_REGION:-}"
    local aws_cmd="aws secretsmanager update-secret"

    # Add profile if specified
    if [ -n "$aws_profile" ]; then
        aws_cmd="$aws_cmd --profile $aws_profile"
    fi

    # Add region if specified
    if [ -n "$aws_region" ]; then
        aws_cmd="$aws_cmd --region $aws_region"
    fi

    # Update the secret
    if ! $aws_cmd \
        --secret-id "$secret_name" \
        --secret-string "$new_value" >/dev/null 2>&1; then
        lib_log_error "Failed to rotate secret '$secret_name'"
        return 1
    fi

    lib_log_info "Successfully rotated secret '$secret_name'"
    return 0
}

# Main script logic
main() {
    # Check AWS credentials
    if ! lib_aws_check_credentials; then
        exit 1
    fi

    # Parse command line arguments
    local operation="$1"
    local secret_name="$2"
    local value="$3"

    # Validate secret name
    if ! validate_secret_name "$secret_name"; then
        exit 1
    fi

    case "$operation" in
        "get")
            if ! lib_aws_get_secret "$secret_name"; then
                exit 1
            fi
            ;;
        "get-value")
            if ! lib_aws_get_secret_value "$secret_name" "$value"; then
                exit 1
            fi
            ;;
        "rotate")
            if ! rotate_secret "$secret_name" "$value"; then
                exit 1
            fi
            ;;
        *)
            lib_log_error "Invalid operation: $operation"
            echo "Usage: $0 {get|get-value|rotate} secret-name [value]"
            exit 1
            ;;
    esac
}

# Only run main if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [ $# -lt 2 ]; then
        echo "Usage: $0 {get|get-value|rotate} secret-name [value]"
        exit 1
    fi
    main "$@"
fi 