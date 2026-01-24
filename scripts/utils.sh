#!/bin/bash

#===============================================================================
# Utility Functions
# Shared helper functions for dotfiles scripts
#===============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Print functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if running on macOS
is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

# Check if running on Apple Silicon
is_apple_silicon() {
    [[ "$(uname -m)" == "arm64" ]]
}

# Get Homebrew prefix
get_brew_prefix() {
    if is_apple_silicon; then
        echo "/opt/homebrew"
    else
        echo "/usr/local"
    fi
}
