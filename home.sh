#!/bin/bash

# Install Docker for home environment
brew install --cask docker

# Copy home environment configurations
cp home.p10k.zsh ~/.p10k.zsh
cp home.zshrc ~/.zshrc

echo "Home environment setup complete!"
