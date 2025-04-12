#!/bin/bash

# Function to display usage information
show_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "This script runs the overlord command with template_project.over."
    echo "Any options passed to this script will be forwarded to the overlord command."
    echo ""
    echo "Default command: overlord create template_project.over --board tangnano9k"
    echo ""
    echo "Examples:"
    echo "  $0                                  # Run with defaults"
    echo "  $0 --out custom_output              # Specify output directory"
    echo "  $0 --trace Main,utils.Logging       # Enable trace logging"
    echo "  $0 --board icestick                 # Use different board"
    echo "  $0 --noexit                         # Don't exit on error"
    echo ""
    echo "For all available options, see overlord's help: overlord --help"
}

# Show usage if help is requested
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_usage
    exit 0
fi

# Check if overlord command is available in the system
if ! command -v overlord &> /dev/null; then
    echo "Error: 'overlord' command not found."
    echo ""
    echo "Please install overlord from GitHub: https://github.com/DeanoC/overlord"
    echo ""
    echo "Installation options:"
    echo "1. Download and install the Debian package (.deb) from the latest release"
    echo "2. Build from source:"
    echo "   - Clone the repository"
    echo "   - Run 'sbt debian:packageBin' to create the package"
    echo "   - Install with 'sudo dpkg -i target/overlord_1.0_all.deb'"
    echo "3. Use the local bin version:"
    echo "   - Download the standalone archive from the releases page"
    echo "   - Extract it and use './bin/overlord' directly"
    echo ""
    echo "For detailed installation instructions, see the docs/cli-installation.md file"
    exit 1
fi

# Default parameters
BOARD="tangnano9k"
COMMAND="create"
PROJECT_FILE="template_project.over"

# Process arguments to properly handle both formats (--option=value and --option value)
PROCESSED_ARGS=()

# Extract any debug/trace options first to ensure they're processed before other operations
DEBUG_TRACE_ARGS=()
OTHER_ARGS=()

for arg in "$@"; do
    if [[ $arg == --debug* || $arg == --trace* ]]; then
        # This is a debug or trace argument - add it to the front
        DEBUG_TRACE_ARGS+=("$arg")
    else
        # This is some other argument
        OTHER_ARGS+=("$arg") 
    fi
done

# Combine arguments with debug/trace options first
PROCESSED_ARGS=("${DEBUG_TRACE_ARGS[@]}" "${OTHER_ARGS[@]}")

# Override board if specified in arguments
if [[ "$*" == *"--board"* || "$*" == *"--board="* ]]; then
    # Board is specified in arguments, don't use the default
    BOARD_ARG=""
else
    BOARD_ARG="--board $BOARD"
fi

# Run overlord command with parameters - debug/trace options first to enable logging early
echo "Running: overlord $COMMAND $PROJECT_FILE $BOARD_ARG ${PROCESSED_ARGS[*]}"
overlord $COMMAND $PROJECT_FILE $BOARD_ARG "${PROCESSED_ARGS[@]}"
