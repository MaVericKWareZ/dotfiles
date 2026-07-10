# Dotfiles

> A production-ready dotfiles repository for macOS Apple Silicon, optimized for terminal-first polyglot development.

![macOS](https://img.shields.io/badge/macOS-Apple%20Silicon-black)
![Shell](https://img.shields.io/badge/Shell-zsh-green)
![License](https://img.shields.io/badge/License-MIT-blue)

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Run the bootstrap script
cd ~/dotfiles
./install.sh

# Or preview changes first
./install.sh --dry-run
```

## ✨ Features

- **Fast shell startup** with deferred loading for heavy tools (nvm, pyenv, SDKMAN)
- **Powerlevel10k** prompt with contextual segments (git, node, python, k8s)
- **SSH commit signing** configured out of the box
- **Declarative packages** via Brewfile
- **Idempotent bootstrap** - safe to run multiple times
- **Work/personal separation** with conditional git configs
- **macOS optimizations** via sensible defaults

## 📦 What's Included

| Category | Tools |
|----------|-------|
| **Shell** | zsh + Oh My Zsh + Powerlevel10k |
| **Version Managers** | nvm (Node), pyenv (Python), SDKMAN (Java) |
| **CLI Tools** | fzf, ripgrep, fd, bat, eza, jq, yq |
| **Git** | diff-so-fancy, gh CLI, SSH signing |
| **Containers** | Docker, kubectl, minikube |
| **Apps** | iTerm2, VS Code, IntelliJ, Raycast, Rectangle |

## 📂 Repository Structure

```
dotfiles/
├── install.sh              # Bootstrap script
├── Brewfile                # Homebrew dependencies
├── Brewfile.work           # Work-specific packages (optional)
├── Brewfile.personal       # Personal packages (optional)
│
├── zsh/                    # Shell configuration
│   ├── .zshrc              # Main zsh config
│   ├── .zshenv             # Environment variables (all shells)
│   ├── .p10k.zsh           # Powerlevel10k prompt config
│   └── .zsh/
│       ├── aliases.zsh     # All aliases
│       ├── functions.zsh   # Shell functions
│       └── deferred.zsh    # Lazy-loaded tools (nvm, pyenv, SDKMAN)
│
├── git/                    # Git configuration
│   ├── .gitconfig          # Main git config
│   ├── .gitconfig-work     # Work identity override
│   └── .gitignore_global   # Global gitignore
│
├── vim/                    # Vim configuration
│   └── .vimrc              # Minimal vim setup
│
├── tmux/                   # tmux configuration
│   └── .tmux.conf          # Terminal multiplexer setup (tpm plugins)
│
├── macos/                  # macOS settings
│   └── defaults.sh         # System preferences
│
├── vscode/                 # VS Code settings
│   └── settings.json       # Editor preferences
│
└── scripts/                # Utility scripts
    ├── backup.sh           # Backup existing dotfiles
    └── utils.sh            # Helper functions
```

## 🛠 Installation

### Prerequisites

- macOS (Apple Silicon)
- Xcode Command Line Tools (`xcode-select --install`)

### Full Installation

```bash
# Install everything
./install.sh
```

### Selective Installation

```bash
# Install only specific components
./install.sh brew     # Homebrew + packages only
./install.sh shell    # Shell configuration only
./install.sh stow     # Symlink dotfiles only
./install.sh git      # Git configuration only
./install.sh vscode   # VS Code settings symlink
./install.sh macos    # macOS defaults only
```

### Dry Run

Preview changes without applying them:

```bash
./install.sh --dry-run
```

## ⚙️ Post-Installation

After running the bootstrap script:

1. **Restart your terminal** or run `source ~/.zshrc`

2. **Configure Powerlevel10k** (if not already configured):
   ```bash
   p10k configure
   ```

3. **Set iTerm2 font** to "FiraCode Nerd Font"

4. **Update Git identity** in `~/.gitconfig`:
   ```ini
   [user]
       name = Your Name
       email = your.email@example.com
   ```

5. **Set up SSH key for Git** (if not done):
   ```bash
   ssh-keygen -t ed25519 -C "your.email@example.com"
   ssh-add --apple-use-keychain ~/.ssh/id_ed25519
   ```
   Add the public key to GitHub: `pbcopy < ~/.ssh/id_ed25519.pub`

## 👔 Work Machine Setup

For work machines, create/edit `~/.gitconfig-work` with your work identity:

```ini
[user]
    name = Your Work Name
    email = your.work@company.com
```

Any repos cloned under `~/work/` will automatically use this identity.

## 🔧 Customization

### Adding Aliases

Edit `zsh/.zsh/aliases.zsh`:

```zsh
alias myalias='my command'
```

### Adding Functions

Edit `zsh/.zsh/functions.zsh`:

```zsh
myfunction() {
    # Your code here
}
```

### Adding Homebrew Packages

Edit `Brewfile`:

```ruby
brew "new-package"
cask "new-app"
```

Then run:

```bash
brew bundle --file=~/dotfiles/Brewfile
```

### Work-Specific Packages

Add to `Brewfile.work`:

```ruby
cask "slack"
cask "zoom"
```

## 🔄 Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```

## 📋 Shell Aliases & Functions

### Git

| Alias | Command |
|-------|---------|
| `gst` | `git status` (OMZ) |
| `gd` | `git diff` (OMZ) |
| `gds` | `git diff --staged` (OMZ) |
| `glog` | Pretty git log (15 commits, graph) |
| `glogall` | Full graph log (30 commits, all branches) |
| `gpf` | `git push --force-with-lease` |
| `gwip` | Quick WIP commit |
| `gunwip` | Undo last WIP commit |
| `gco` | Fuzzy branch checkout (fzf) |
| `gadd` | Interactive fuzzy `git add` (fzf) |
| `gclone` | Clone and cd into repo |

### Docker

| Alias | Command |
|-------|---------|
| `d` | `docker` |
| `dc` | `docker-compose` |
| `dcu` | `docker-compose up` |
| `dcd` | `docker-compose down` |
| `dps` | `docker ps` |
| `dexec` | Interactive container exec (fzf) |
| `dlogs` | Follow container logs (fzf) |

### Development

| Alias | Command |
|-------|---------|
| `c` | `code .` |
| `ni` | `npm install` |
| `nr` | `npm run` |
| `nrd` | `npm run dev` |
| `venv` | Create & activate Python venv |
| `serve` | Quick Python HTTP server |

### Utility Functions

| Function | Description |
|----------|-------------|
| `mkcd <dir>` | Create directory and cd into it |
| `fcd` | Fuzzy find and cd into directory |
| `extract <file>` | Extract any archive format |
| `killport <port>` | Kill process on port |
| `genpass [length]` | Generate random password (default 32 chars) |
| `frg` | Fuzzy ripgrep with editor preview |
| `fif <term>` | Find in files with bat preview |
| `topcmds` | Show 20 most-used shell commands |
| `calc <expr>` | Quick arithmetic via bc |
| `json` | Pretty-print JSON (pipe or file) |
| `serve [port]` | Quick Python HTTP server (default :8000) |
| `notify <cmd>` | Run command and send macOS notification on finish |
| `dexec` | Fuzzy exec into running Docker container |
| `dlogs` | Fuzzy follow logs for running Docker container |

## ⚡ Performance

Shell startup is optimized with deferred loading:

| Tool | Load Strategy |
|------|---------------|
| nvm | Lazy (first `node`/`npm` call) |
| pyenv | Lazy (first `pyenv` call) |
| SDKMAN | Lazy (first `java`/`sdk` call) |

Typical startup time: **< 100ms** (without first-use tool loading)

## 📝 macOS Defaults

The `macos/defaults.sh` script configures:

- **Keyboard**: Fast key repeat, no press-and-hold
- **Trackpad**: Tap to click, natural scrolling
- **Finder**: Show hidden files, list view, extensions
- **Dock**: Small icons, no recent apps
- **Screenshots**: PNG, no shadow, saved to ~/Screenshots
- **Animations**: Most disabled for performance

## 🔐 Security

- SSH signing for Git commits
- SSH keys stored in macOS Keychain
- No secrets committed to repo
- Global gitignore for sensitive files

## 📄 License

MIT License - feel free to use and modify.

## 🙏 Credits

Inspired by the dotfiles community and countless open-source contributions.
