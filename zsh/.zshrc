#===============================================================================
# ~/.zshrc - Main zsh configuration
# Managed by dotfiles: https://github.com/yourusername/dotfiles
#===============================================================================

#-------------------------------------------------------------------------------
# Powerlevel10k Instant Prompt
# Keep this at the top for fast prompt rendering
#-------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#-------------------------------------------------------------------------------
# Oh My Zsh Configuration
#-------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git                    # Git aliases and completions
  docker                 # Docker completions
  docker-compose         # Docker Compose completions
  kubectl                # Kubernetes completions
  aws                    # AWS completions
  fzf                    # Fuzzy finder integration
  zsh-autosuggestions    # Fish-like suggestions
  zsh-syntax-highlighting # Command syntax highlighting
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

#-------------------------------------------------------------------------------
# Environment Variables
#-------------------------------------------------------------------------------

# Preferred editor
export EDITOR='vim'
export VISUAL='code'

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

#-------------------------------------------------------------------------------
# History Configuration
#-------------------------------------------------------------------------------
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS      # Don't show duplicates when searching
setopt HIST_REDUCE_BLANKS     # Remove blank lines
setopt INC_APPEND_HISTORY     # Add commands immediately
setopt EXTENDED_HISTORY       # Save timestamps

#-------------------------------------------------------------------------------
# Shell Options
#-------------------------------------------------------------------------------
setopt AUTO_CD                # cd by just typing directory name
setopt CORRECT                # Spelling correction for commands
setopt NO_BEEP                # No beeping
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell

#-------------------------------------------------------------------------------
# Key Bindings
#-------------------------------------------------------------------------------
bindkey -e                    # Emacs key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#-------------------------------------------------------------------------------
# Custom Aliases
#-------------------------------------------------------------------------------
source "$HOME/.zsh/aliases.zsh" 2>/dev/null

#-------------------------------------------------------------------------------
# Custom Functions
#-------------------------------------------------------------------------------
source "$HOME/.zsh/functions.zsh" 2>/dev/null

#-------------------------------------------------------------------------------
# Deferred Loading (Heavy Tools)
# These are loaded lazily for faster shell startup
#-------------------------------------------------------------------------------
source "$HOME/.zsh/deferred.zsh" 2>/dev/null

#-------------------------------------------------------------------------------
# fzf Configuration
#-------------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf options
export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border
  --info=inline
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

# Use fd for fzf if available
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
export PATH="/opt/homebrew/opt/openssh/bin:$PATH"

#-------------------------------------------------------------------------------
# Modern CLI Tool Aliases
#-------------------------------------------------------------------------------
# Use modern replacements if available
command -v bat &> /dev/null && alias cat='bat --paging=never'
command -v eza &> /dev/null && alias ls='eza --icons' && alias ll='eza -la --icons' && alias la='eza -a --icons'

#-------------------------------------------------------------------------------
# Powerlevel10k Configuration
#-------------------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/maverick/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
source /opt/homebrew/opt/nvm/nvm.sh
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Added by Antigravity
export PATH="/Users/maverick/.antigravity/antigravity/bin:$PATH"
