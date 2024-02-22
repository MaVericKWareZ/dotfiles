# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# set python3 as python by default
alias python="python3"
alias pip="pip3"

# alias localstackup = "docker run --rm -itd -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack"
alias stage_tunnel="ssh -N -L 8001:farmrise-agronomy-stage.catb0abxdt82.ap-south-1.rds.amazonaws.com:5432 stfrnew"
alias qa_tunnel="ssh -N -L 8000:farmrise-qa.catb0abxdt82.ap-south-1.rds.amazonaws.com:5432 farmrise-test"

# enable java 8
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
# export java_version=8

# enable java 11
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export java_version=11

# enable java 17
# export JAVA_HOME=$(/usr/libexec/java_home -v 17)
# export java_version=17


# maven config
export M2_HOME=~/java_dev/apache-maven-3.8.6
export PATH=$PATH:$M2_HOME/bin
# Replace github_pat here 
export github_pat=foobar 

# command to ssh into jumpbox for env 
ssh_vault(){
  if [ "$#" -ne 1 ]; then
        echo "Usage: ssh_vault <hostname>"
  else
    export VAULT_ADDR='https://vault.agro.services' 
    vault login --method=oidc 
    vault write -field signed_key ssh/sign/monuser public_key=@$HOME/.ssh/id_rsa.pub > $HOME/.ssh/id_rsa-cert.pub 
    chmod 0600 $HOME/.ssh/id_rsa-cert.pub 
    ssh -i $HOME/.ssh/id_rsa monuser@ssh.platforms.engineering
    ssh $1
  fi
}

# command to create ssh tunnel into env
ssh_tunnel() {
    # Declare an associative array
    typeset -A url_mapping

    # Mapping of keywords to URLs
    url_mapping[mongo_qa]="docdb-test-stage-cluster-new.cluster-catb0abxdt82.ap-south-1.docdb.amazonaws.com:27017"
    url_mapping[postgres_qa]="farmrise-qa.catb0abxdt82.ap-south-1.rds.amazonaws.com:5432"
    url_mapping[redis_qa]="clustercfg.farmrise-redis-qa-new.pgaimi.aps1.cache.amazonaws.com:6379"
    url_mapping[mongo_stage]="docdb-test-stage-cluster-new.cluster-catb0abxdt82.ap-south-1.docdb.amazonaws.com:27017"
    url_mapping[postgres_stage]="farmrise-agronomy-stage.catb0abxdt82.ap-south-1.rds.amazonaws.com:5432"
    url_mapping[redis_stage]="clustercfg.farmrise-redis-stage-encrypted.pgaimi.aps1.cache.amazonaws.com:6379"

    # Check for the list option
    if [[ "$1" == "--list" || "$1" == "-l" ]]; then
        echo "Available Keywords:"
        for key in "${(@k)url_mapping}"; do
            echo "$key"
        done
        return 0
    fi

    # Replace keyword with corresponding URL or use provided URL
    # Check if the keyword exists in the mapping
    if [[ -n "${url_mapping[$3]}" ]]; then
        # Use the mapped URL
        url="${url_mapping[$3]}"
    else
        # Use the provided URL
        url="$3"
    fi
    echo "connecting to : $url"

    # Execute the SSH tunnel command
    ssh -N -L "$2:$url" "$1" -v
}





# command to change java version
change_java(){
  if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
  else
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export java_version=$1
  fi
}

# bayer proxy config
source ~/bayer-proxy-env/bayer-proxy-env.sh
export proxy_user=gnhco
export proxy_ip=10.50.69.70
export proxy_port=8080
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/gnhco/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export DYNAMO_ENDPOINT="http://localhost:8000 dynamodb-admin"

export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
