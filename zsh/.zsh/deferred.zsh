#===============================================================================
# Deferred Loading - Lazy initialization for heavy tools
# Sourced by .zshrc
# 
# This file implements lazy loading for slow-to-initialize tools
# to keep shell startup fast. Tools are loaded on first use.
#===============================================================================

#-------------------------------------------------------------------------------
# NVM (Node Version Manager)
# Lazy load - only initialize when node/npm/nvm is first called
#-------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"

# Lazy load function
_load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

# Create wrapper functions that load nvm on first use
nvm() {
  _load_nvm
  nvm "$@"
}

node() {
  _load_nvm
  node "$@"
}

npm() {
  _load_nvm
  npm "$@"
}

npx() {
  _load_nvm
  npx "$@"
}

#-------------------------------------------------------------------------------
# pyenv (Python Version Manager)
# Lazy load - only initialize when python/pyenv is first called
#-------------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"

_load_pyenv() {
  unset -f pyenv python python3 pip pip3
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
  fi
}

pyenv() {
  _load_pyenv
  pyenv "$@"
}

# Only wrap if system python isn't preferred
# Comment these out if you want system python to be immediately available
# python() {
#   _load_pyenv
#   python "$@"
# }
# 
# python3() {
#   _load_pyenv
#   python3 "$@"
# }

#-------------------------------------------------------------------------------
# SDKMAN (Java Version Manager)
# Lazy load - only initialize when java/sdk/gradle/mvn is first called
#-------------------------------------------------------------------------------
export SDKMAN_DIR="$HOME/.sdkman"

_load_sdkman() {
  unset -f sdk java gradle mvn
  [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
}

sdk() {
  _load_sdkman
  sdk "$@"
}

java() {
  _load_sdkman
  java "$@"
}

gradle() {
  _load_sdkman
  gradle "$@"
}

mvn() {
  _load_sdkman
  mvn "$@"
}

#-------------------------------------------------------------------------------
# Notes on Deferred Loading
#-------------------------------------------------------------------------------
# Benefits:
# - Shell startup is fast (< 100ms typically)
# - Heavy tools only load when needed
# 
# Trade-offs:
# - First invocation of each tool has a small delay
# - Some autocompletions may not work until tool is loaded
#
# To disable lazy loading for a specific tool, comment out its section
# above and add direct sourcing in .zshrc instead.
#-------------------------------------------------------------------------------
