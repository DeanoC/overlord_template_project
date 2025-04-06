#!/bin/bash

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

# Run overlord command with the template project
overlord create template_project.over --board tangnano9k
