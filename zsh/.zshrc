#===============================================================================
# ~/.zshrc - Main zsh configuration
#===============================================================================

#-------------------------------------------------------------------------------
# Powerlevel10k Instant Prompt
# Must stay at the very top for fast prompt rendering
#-------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#-------------------------------------------------------------------------------
# Environment Variables & PATH
# Homebrew must come first so all subsequent tools find the correct binaries
#-------------------------------------------------------------------------------

# Homebrew (Apple Silicon) — initialised before Oh My Zsh
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Preferred editor
export EDITOR='vim'
export VISUAL='code'

# Language / Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# OpenSSH (Homebrew-managed, for newer ssh features)
export PATH="/opt/homebrew/opt/openssh/bin:$PATH"

# Antigravity
export PATH="/Users/maverick/.antigravity/antigravity/bin:$PATH"

#-------------------------------------------------------------------------------
# Completion fpath
# Add custom completion directories BEFORE Oh My Zsh so that OMZ's single
# compinit call picks them all up — avoids running compinit twice.
#-------------------------------------------------------------------------------
fpath=(/Users/maverick/.docker/completions $fpath)

#-------------------------------------------------------------------------------
# Oh My Zsh Configuration
#-------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
# Note: fzf is intentionally absent — it is initialised via `fzf --zsh` below,
# which is the modern approach and avoids double-initialisation with ~/.fzf.zsh.
plugins=(
  git                    # Git aliases and completions
  docker                 # Docker completions
  docker-compose         # Docker Compose completions
  kubectl                # Kubernetes completions
  aws                    # AWS completions
  zsh-autosuggestions    # Fish-like autosuggestions
  zsh-syntax-highlighting # Command syntax highlighting
)

# Load Oh My Zsh (runs compinit once internally)
source $ZSH/oh-my-zsh.sh

#-------------------------------------------------------------------------------
# History Configuration
#-------------------------------------------------------------------------------
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

setopt SHARE_HISTORY          # Share history across all sessions
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS      # Don't show duplicates during search
setopt HIST_REDUCE_BLANKS     # Strip superfluous blank lines
setopt INC_APPEND_HISTORY     # Write commands immediately, not on exit
setopt EXTENDED_HISTORY       # Save timestamps alongside commands

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------
setopt AUTO_CD                # cd by typing directory name alone
setopt CORRECT                # Spelling correction for commands
setopt NO_BEEP                # Silence the bell
setopt INTERACTIVE_COMMENTS   # Allow # comments in interactive shell

#-------------------------------------------------------------------------------
# Key Bindings
#-------------------------------------------------------------------------------
bindkey -e                    # Emacs key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#-------------------------------------------------------------------------------
# Modules — aliases, functions, and lazy-loaded heavy tools
#-------------------------------------------------------------------------------
source "$HOME/.zsh/aliases.zsh"   2>/dev/null
source "$HOME/.zsh/functions.zsh" 2>/dev/null
source "$HOME/.zsh/deferred.zsh"  2>/dev/null

#-------------------------------------------------------------------------------
# fzf Configuration
# Sourced via fzf --zsh (modern API). The OMZ fzf plugin is not needed.
#-------------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border
  --info=inline
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

# Use fd for fzf if available (faster, honours .gitignore)
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

#-------------------------------------------------------------------------------
# Powerlevel10k Configuration
# To customise the prompt, run `p10k configure` or edit ~/.p10k.zsh
#-------------------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
