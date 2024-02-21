#!/bin/bash

echo "Starting setup of development tools"

if [ -f .env ]; then
  source .env
else
  echo "Error: .env file not found!"
  exit 1
fi

echo "env variables loaded"

echo "First, we will install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "brew installation complete!"

echo "Next, we will install iterm"
brew install --cask iterm2
echo "iterm installation complete!"

echo "Next, we will install git"
brew install git
echo "git installation complete!"

echo "git configuration started"
git config --global user.email "$GIT_EMAIL"
git config --global credential.helper osxkeychain
git credential-osxkeychain erase
echo "protocol=https" > ~/.git-credentials
echo "host=github.com" >> ~/.git-credentials
echo "username=$GIT_EMAIL" >> ~/.git-credentials
echo "password=$GIT_PAT" >> ~/.git-credentials
echo "git configuration complete!"

echo "ZSH installation started"
brew install zsh
chsh -s $(which zsh)
echo "ZSH installation complete!"

echo "oh-my-zsh installation started"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
echo "oh-my-zsh installation complete!"

echo "visual-studio-code installation started"
brew install --cask visual-studio-code
echo "visual-studio-code installation complete!"

echo "postman installation started"
brew install --cask postman
echo "postman installation complete!"

echo "displaylink installation started"
brew install --cask displaylink
echo "displaylink installation complete!"

if [ "$MODE" = "work" ]; then
    echo "installing work.sh"
    source work.sh
else
    echo "installing home.sh"
    source home.sh
fi

source ~/.zshrc

if [ "$EXTRAS" = "on" ]; then
    echo "installing extras.sh"
    source extras.sh
fi


echo "Setup is complete! Your machine is ready for development! ."
