#===============================================================================
# Shell Functions
# Sourced by .zshrc
#===============================================================================

#-------------------------------------------------------------------------------
# Directory Navigation
#-------------------------------------------------------------------------------

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Find and cd into directory using fzf
fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git . "${1:-.}" | fzf --height 40% --reverse) && cd "$dir"
}

#-------------------------------------------------------------------------------
# File Operations
#-------------------------------------------------------------------------------

# Extract any archive
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create a backup of a file
bak() {
  cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
}

#-------------------------------------------------------------------------------
# Development
#-------------------------------------------------------------------------------

# Quick Python HTTP server
serve() {
  local port="${1:-8000}"
  echo "Serving at http://localhost:$port"
  python3 -m http.server "$port"
}

# Run a command and notify when done (macOS)
notify() {
  "$@"
  local exit_code=$?
  if [[ $exit_code -eq 0 ]]; then
    osascript -e 'display notification "Command completed successfully" with title "Terminal"'
  else
    osascript -e 'display notification "Command failed" with title "Terminal"'
  fi
  return $exit_code
}

#-------------------------------------------------------------------------------
# Git Functions
#-------------------------------------------------------------------------------

# Clone and cd into repo
gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# Interactive git add with fzf
gadd() {
  local files
  files=$(git status -s | fzf -m --height 40% --reverse | awk '{print $2}')
  [[ -n "$files" ]] && echo "$files" | xargs git add && git status -s
}

# Checkout branch with fzf
gco() {
  local branch
  branch=$(git branch --all | grep -v HEAD | sed 's/.* //' | sed 's/remotes\/origin\///' | sort -u | fzf --height 40% --reverse)
  [[ -n "$branch" ]] && git checkout "$branch"
}

#-------------------------------------------------------------------------------
# Docker Functions
#-------------------------------------------------------------------------------

# Docker exec into container with fzf
dexec() {
  local container
  container=$(docker ps --format '{{.Names}}' | fzf --height 40% --reverse)
  [[ -n "$container" ]] && docker exec -it "$container" "${1:-sh}"
}

# Docker logs with fzf
dlogs() {
  local container
  container=$(docker ps --format '{{.Names}}' | fzf --height 40% --reverse)
  [[ -n "$container" ]] && docker logs -f "$container"
}

#-------------------------------------------------------------------------------
# Search Functions
#-------------------------------------------------------------------------------

# Fuzzy grep with preview
fgrep() {
  local file line
  read -r file line <<< "$(rg --line-number --no-heading . 2>/dev/null | fzf -d ':' --preview 'bat --color=always {1} --highlight-line {2}' | awk -F: '{print $1, $2}')"
  [[ -n "$file" ]] && ${EDITOR:-vim} "+$line" "$file"
}

# Find in files with preview
fif() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: fif <search term>"
    return 1
  fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "bat --color=always {} | rg --color=always --context 3 '$1'"
}

#-------------------------------------------------------------------------------
# Process Management
#-------------------------------------------------------------------------------

# Kill process by port
killport() {
  if [[ -z "$1" ]]; then
    echo "Usage: killport <port>"
    return 1
  fi
  lsof -ti:"$1" | xargs kill -9 2>/dev/null && echo "Killed process on port $1" || echo "No process found on port $1"
}

# Find process by name
psgrep() {
  ps aux | grep -v grep | grep -i "$1"
}

#-------------------------------------------------------------------------------
# Utility
#-------------------------------------------------------------------------------

# Generate a random password
genpass() {
  local length="${1:-32}"
  LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | head -c "$length"
  echo
}

# Show most used commands
topcmds() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head -20
}

# Calculator
calc() {
  echo "scale=2; $*" | bc
}

# JSON pretty print
json() {
  if [[ -p /dev/stdin ]]; then
    cat - | jq '.'
  else
    jq '.' < "$1"
  fi
}
