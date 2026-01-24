#===============================================================================
# ~/.zshenv - Environment variables loaded for all shells
# This file is sourced first, for all zsh instances (login, interactive, scripts)
#===============================================================================

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Ensure path arrays don't contain duplicates
typeset -U path

# Add local bin to PATH
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
