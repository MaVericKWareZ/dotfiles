#!/bin/bash

#===============================================================================
# Dotfiles Bootstrap Script
# 
# A single, idempotent script to set up a new macOS machine.
# 
# Usage:
#   ./install.sh [OPTIONS] [COMPONENT...]
#
# Options:
#   --dry-run     Preview changes without applying them
#   --help        Show this help message
#
# Components:
#   all           Install everything (default)
#   brew          Install Homebrew and packages
#   shell         Configure zsh, Oh My Zsh, Powerlevel10k
#   git           Configure Git
#   macos         Apply macOS defaults
#   stow          Symlink dotfiles using GNU Stow
#
# Examples:
#   ./install.sh                  # Install everything
#   ./install.sh --dry-run        # Preview all changes
#   ./install.sh shell git        # Install only shell and git configs
#===============================================================================

set -euo pipefail

#-------------------------------------------------------------------------------
# Configuration
#-------------------------------------------------------------------------------

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
DRY_RUN=false
COMPONENTS=()

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

#-------------------------------------------------------------------------------
# Helper Functions
#-------------------------------------------------------------------------------

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

dry_run() {
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${YELLOW}[DRY-RUN]${NC} Would execute: $*"
        return 0
    fi
    return 1
}

backup_file() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        mkdir -p "$BACKUP_DIR"
        info "Backing up $file to $BACKUP_DIR/"
        if ! dry_run "mv $file $BACKUP_DIR/"; then
            mv "$file" "$BACKUP_DIR/"
        fi
    fi
}

command_exists() {
    command -v "$1" &> /dev/null
}

#-------------------------------------------------------------------------------
# Prerequisites Check
#-------------------------------------------------------------------------------

check_prerequisites() {
    info "Checking prerequisites..."
    
    # Check for macOS
    if [[ "$(uname)" != "Darwin" ]]; then
        error "This script is designed for macOS only."
        exit 1
    fi
    
    # Check for Xcode Command Line Tools
    if ! xcode-select -p &> /dev/null; then
        info "Installing Xcode Command Line Tools..."
        if ! dry_run "xcode-select --install"; then
            xcode-select --install
            echo "Please complete the Xcode CLI tools installation, then re-run this script."
            exit 0
        fi
    else
        success "Xcode Command Line Tools already installed"
    fi
}

#-------------------------------------------------------------------------------
# Homebrew Installation
#-------------------------------------------------------------------------------

install_homebrew() {
    info "Setting up Homebrew..."
    
    if ! command_exists brew; then
        info "Installing Homebrew..."
        if ! dry_run '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        # Add Homebrew to PATH for Apple Silicon
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        success "Homebrew already installed"
    fi
    
    # Install packages from Brewfile
    if [[ -f "$DOTFILES_DIR/Brewfile" ]]; then
        info "Installing packages from Brewfile..."
        if ! dry_run "brew bundle --file=$DOTFILES_DIR/Brewfile"; then
            brew bundle --file="$DOTFILES_DIR/Brewfile"
        fi
    fi
    
    # Install work-specific packages if Brewfile.work exists
    if [[ -f "$DOTFILES_DIR/Brewfile.work" ]]; then
        info "Installing work-specific packages..."
        if ! dry_run "brew bundle --file=$DOTFILES_DIR/Brewfile.work"; then
            brew bundle --file="$DOTFILES_DIR/Brewfile.work"
        fi
    fi
    
    # Install personal packages if Brewfile.personal exists
    if [[ -f "$DOTFILES_DIR/Brewfile.personal" ]]; then
        info "Installing personal packages..."
        if ! dry_run "brew bundle --file=$DOTFILES_DIR/Brewfile.personal"; then
            brew bundle --file="$DOTFILES_DIR/Brewfile.personal"
        fi
    fi
    
    success "Homebrew setup complete"
}

#-------------------------------------------------------------------------------
# GNU Stow - Symlink Dotfiles
#-------------------------------------------------------------------------------

stow_dotfiles() {
    info "Symlinking dotfiles with GNU Stow..."
    
    if ! command_exists stow; then
        error "GNU Stow not installed. Run './install.sh brew' first."
        return 1
    fi
    
    # Stow each package
    local packages=("zsh" "git" "vim")
    
    for package in "${packages[@]}"; do
        if [[ -d "$DOTFILES_DIR/$package" ]]; then
            info "Stowing $package..."
            
            # Backup existing files before stowing
            for file in "$DOTFILES_DIR/$package"/.*; do
                [[ -e "$file" ]] || continue
                local basename=$(basename "$file")
                [[ "$basename" == "." || "$basename" == ".." ]] && continue
                backup_file "$HOME/$basename"
            done
            
            if ! dry_run "stow -v -d $DOTFILES_DIR -t $HOME $package"; then
                stow -v -d "$DOTFILES_DIR" -t "$HOME" "$package"
            fi
        fi
    done
    
    success "Dotfiles symlinked"
}

#-------------------------------------------------------------------------------
# Shell Configuration
#-------------------------------------------------------------------------------

setup_shell() {
    info "Setting up shell configuration..."
    
    # Install Oh My Zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Installing Oh My Zsh..."
        if ! dry_run 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        fi
    else
        success "Oh My Zsh already installed"
    fi
    
    # Install Powerlevel10k
    local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ ! -d "$p10k_dir" ]]; then
        info "Installing Powerlevel10k..."
        if ! dry_run "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $p10k_dir"; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
        fi
    else
        success "Powerlevel10k already installed"
    fi
    
    # Install zsh-autosuggestions
    local autosuggestions_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    if [[ ! -d "$autosuggestions_dir" ]]; then
        info "Installing zsh-autosuggestions..."
        if ! dry_run "git clone https://github.com/zsh-users/zsh-autosuggestions $autosuggestions_dir"; then
            git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions_dir"
        fi
    else
        success "zsh-autosuggestions already installed"
    fi
    
    # Install zsh-syntax-highlighting
    local syntax_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    if [[ ! -d "$syntax_dir" ]]; then
        info "Installing zsh-syntax-highlighting..."
        if ! dry_run "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $syntax_dir"; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_dir"
        fi
    else
        success "zsh-syntax-highlighting already installed"
    fi
    
    # Install SDKMAN
    if [[ ! -d "$HOME/.sdkman" ]]; then
        info "Installing SDKMAN..."
        if ! dry_run 'curl -s "https://get.sdkman.io?rcupdate=false" | bash'; then
            curl -s "https://get.sdkman.io?rcupdate=false" | bash
        fi
    else
        success "SDKMAN already installed"
    fi
    
    success "Shell setup complete"
}

#-------------------------------------------------------------------------------
# Git Configuration
#-------------------------------------------------------------------------------

setup_git() {
    info "Setting up Git configuration..."
    
    # Configure diff-so-fancy if installed
    if command_exists diff-so-fancy; then
        info "Configuring diff-so-fancy..."
        if ! dry_run "git config --global core.pager 'diff-so-fancy | less --tabs=4 -RF'"; then
            git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
        fi
    fi
    
    # Setup fzf key bindings if installed
    if [[ -f /opt/homebrew/opt/fzf/install ]]; then
        info "Setting up fzf key bindings..."
        if ! dry_run "/opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc"; then
            /opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
        fi
    fi
    
    success "Git setup complete"
}

#-------------------------------------------------------------------------------
# macOS Defaults
#-------------------------------------------------------------------------------

setup_macos() {
    info "Applying macOS defaults..."
    
    if [[ -f "$DOTFILES_DIR/macos/defaults.sh" ]]; then
        if ! dry_run "bash $DOTFILES_DIR/macos/defaults.sh"; then
            bash "$DOTFILES_DIR/macos/defaults.sh"
        fi
    else
        warn "macos/defaults.sh not found, skipping macOS configuration"
    fi
    
    success "macOS defaults applied"
}

#-------------------------------------------------------------------------------
# Usage / Help
#-------------------------------------------------------------------------------

show_help() {
    head -n 26 "${BASH_SOURCE[0]}" | tail -n 24 | sed 's/^# //' | sed 's/^#//'
}

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------

main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                COMPONENTS+=("$1")
                shift
                ;;
        esac
    done
    
    # Default to all components
    if [[ ${#COMPONENTS[@]} -eq 0 ]]; then
        COMPONENTS=("all")
    fi
    
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║                    Dotfiles Bootstrap                          ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    
    if [[ "$DRY_RUN" == true ]]; then
        warn "DRY RUN MODE - No changes will be made"
        echo ""
    fi
    
    check_prerequisites
    
    for component in "${COMPONENTS[@]}"; do
        case "$component" in
            all)
                install_homebrew
                setup_shell
                stow_dotfiles
                setup_git
                setup_macos
                ;;
            brew)
                install_homebrew
                ;;
            shell)
                setup_shell
                ;;
            stow)
                stow_dotfiles
                ;;
            git)
                setup_git
                ;;
            macos)
                setup_macos
                ;;
            *)
                error "Unknown component: $component"
                show_help
                exit 1
                ;;
        esac
    done
    
    echo ""
    success "╔════════════════════════════════════════════════════════════════╗"
    success "║                    Setup Complete!                              ║"
    success "╚════════════════════════════════════════════════════════════════╝"
    echo ""
    info "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. Run 'p10k configure' to customize your prompt"
    echo "  3. Open iTerm2 and set font to 'FiraCode Nerd Font'"
    echo ""
}

main "$@"
