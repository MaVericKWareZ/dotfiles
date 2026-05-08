#===============================================================================
# Aliases
# Sourced by .zshrc
#===============================================================================

#-------------------------------------------------------------------------------
# Navigation
#-------------------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# Quick access to common directories
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'
alias proj='cd ~/Projects'
alias work='cd ~/work'

#-------------------------------------------------------------------------------
# File Listing — modern replacements via eza
# Falls back gracefully if eza is not installed
#-------------------------------------------------------------------------------
if command -v eza &> /dev/null; then
  alias ls='eza --icons'
  alias ll='eza -la --icons'
  alias la='eza -a --icons'
fi

#-------------------------------------------------------------------------------
# File Viewing — modern replacement via bat
#-------------------------------------------------------------------------------
command -v bat &> /dev/null && alias cat='bat --paging=never'

#-------------------------------------------------------------------------------
# File Operations
#-------------------------------------------------------------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Disk usage
alias du='du -h'
alias df='df -h'

#-------------------------------------------------------------------------------
# Development
#-------------------------------------------------------------------------------
alias c='code .'
alias idea='open -a "IntelliJ IDEA"'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv .venv && source .venv/bin/activate'
alias activate='source .venv/bin/activate'

# Node
alias ni='npm install'
alias nr='npm run'
alias nrd='npm run dev'
alias nrt='npm run test'
alias nrb='npm run build'

#-------------------------------------------------------------------------------
# Docker
#-------------------------------------------------------------------------------
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dce='docker-compose exec'
alias dcl='docker-compose logs -f'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimg='docker images'

# Docker cleanup
alias dprune='docker system prune -af'
alias dstop='docker stop $(docker ps -q)'

#-------------------------------------------------------------------------------
# Kubernetes
#-------------------------------------------------------------------------------
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kga='kubectl get all'
alias klog='kubectl logs -f'
alias kexec='kubectl exec -it'

#-------------------------------------------------------------------------------
# AWS
#-------------------------------------------------------------------------------
alias awswho='aws sts get-caller-identity'

#-------------------------------------------------------------------------------
# Git — supplements the Oh My Zsh git plugin
#
# Intentional overrides of OMZ defaults:
#   glog / glogall  — richer graph format than OMZ's default `glog`
#
# Removed to avoid conflicts / duplication with OMZ:
#   gs  (OMZ: git stash  | was: git status — use OMZ's `gst` instead)
#   gd  (identical to OMZ's `gd`)
#   gds (identical to OMZ's `gds`)
#-------------------------------------------------------------------------------
alias glog='git log --oneline --graph --decorate -15'
alias glogall='git log --oneline --graph --decorate --all -30'
alias gpf='git push --force-with-lease'
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git reset HEAD~1'

#-------------------------------------------------------------------------------
# Utility
#-------------------------------------------------------------------------------
alias h='history'
alias hg='history | grep'
alias cls='clear'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.zshrc && echo "✓ .zshrc reloaded"'

# IP addresses
alias myip='curl -s ifconfig.me'
alias localip='ipconfig getifaddr en0'

# macOS Finder — show/hide hidden files
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# Flush DNS
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

#-------------------------------------------------------------------------------
# Fun
#-------------------------------------------------------------------------------
alias please='sudo'
alias weather='curl -s wttr.in'
