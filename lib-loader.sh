#!/bin/bash

# Entry point for the Bash library

# Source all the modules from the `modules/` directory
LIB_DIR="$BASH_LIBRARY_PATH/modules"

# Source each module
source "$LIB_DIR/logging.sh"
source "$LIB_DIR/aws.sh"

# Any additional setup can go here
