# Dotfiles Brewfile
# Run: brew bundle --file=Brewfile

#===============================================================================
# Taps
#===============================================================================
tap "homebrew/bundle"
tap "homebrew/cask-fonts"
tap "mongodb/brew"

#===============================================================================
# CLI Essentials
#===============================================================================

# Core utilities
brew "git"                    # Version control
brew "stow"                   # Symlink farm manager
brew "wget"                   # Download utility
brew "curl"                   # Transfer data

# Modern CLI replacements
brew "bat"                    # Better cat with syntax highlighting
brew "eza"                    # Modern ls replacement
brew "fd"                     # Modern find replacement
brew "ripgrep"                # Fast grep replacement
brew "tree"                   # Directory tree viewer
brew "htop"                   # Interactive process viewer
brew "jq"                     # JSON processor
brew "yq"                     # YAML processor

# Fuzzy finder
brew "fzf"                    # Fuzzy finder for shell

# zsh plugins installed via git clone in setup_shell(), not Brew

# Git enhancements
brew "diff-so-fancy"          # Better git diffs
brew "gh"                     # GitHub CLI
brew "git-delta"              # Better diff viewer (alternative)

# HTTP & Data
brew "httpie"                 # User-friendly HTTP client

#===============================================================================
# Development - Version Managers
#===============================================================================

brew "nvm"                    # Node version manager
brew "pyenv"                  # Python version manager
# SDKMAN installed via curl (not available in Homebrew)

#===============================================================================
# Development - Languages & Tools
#===============================================================================

# Go
brew "go"                     # Go programming language

# Python
brew "ruff"                   # Fast Python linter & formatter
brew "uv"                     # Fast Python package/venv manager

# Java
brew "gradle"                 # Gradle build tool
brew "maven"                  # Maven build tool
brew "kotlin"                 # Kotlin language compiler

# Node/JS (managed by nvm, but useful to have global npm)
# npm packages installed globally via nvm

#===============================================================================
# Cloud & Infrastructure
#===============================================================================

# AWS
brew "awscli"                 # AWS CLI v2

# Containers
brew "docker"                 # Docker CLI
brew "docker-compose"         # Docker Compose
brew "docker-credential-helper" # Docker credential store
brew "kubectl"                # Kubernetes CLI
brew "minikube"               # Local Kubernetes

# Kafka & Messaging
brew "kcat"                   # Kafka CLI producer/consumer

# Observability & Testing

#===============================================================================
# Security & Encryption
#===============================================================================

brew "md5sha1sum"             # Checksum utility

#===============================================================================
# File & System Utilities
#===============================================================================

brew "rclone"                 # Cloud storage sync
brew "unar"                   # Archive extractor
brew "pandoc"                 # Universal document converter

#===============================================================================
# Applications (Casks)
#===============================================================================

# Terminal
cask "iterm2"                 # Terminal emulator

# Editors & IDEs
cask "visual-studio-code"     # Code editor

# Containers
cask "docker"                 # Docker Desktop (or use orbstack)
# cask "orbstack"             # Faster Docker alternative (uncomment if preferred)

# Databases
cask "dbeaver-community"      # Universal DB GUI client
cask "mongodb-compass"        # MongoDB GUI

# API & Networking
cask "postman"                # API testing client

# Diagramming

# Browsers
cask "google-chrome"          # Web browser
cask "firefox@developer-edition" # Developer browser

# Productivity
cask "raycast"                # Launcher & productivity tool
cask "rectangle"              # Window management
cask "clipy"                  # Clipboard manager
cask "shottr"                 # Screenshot tool
cask "hiddenbar"             # Menu bar management
cask "betterdisplay"          # Display resolution/scaling

# AI

#===============================================================================
# Fonts
#===============================================================================

cask "font-fira-code-nerd-font"  # Fira Code with Nerd Font icons
