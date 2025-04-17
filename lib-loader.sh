#!/bin/bash

# Entry point for the Bash library

# Source all the modules from the `modules/` directory
LIB_DIR="$(dirname "${BASH_SOURCE[0]}")/modules"

# Source each module
source "$LIB_DIR/datetime.sh"
source "$LIB_DIR/logging.sh"
source "$LIB_DIR/git.sh"
source "$LIB_DIR/validate_params.sh"
source "$LIB_DIR/docker.sh"
source "$LIB_DIR/pipeline.sh"
source "$LIB_DIR/files.sh"
source "$LIB_DIR/aws.sh"

# Any additional setup can go here
