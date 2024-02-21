#!/bin/bash

echo "Starting setup of development tools"


echo "First, we will install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "brew installation complete!"

echo "Next, we will install iterm"
brew install --cask iterm2
echo "iterm installation complete!"


echo "Next, we will install git"
brew install git
echo "git installation complete!"



echo "Setup is complete! Your machine is ready for development!"
