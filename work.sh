#!/bin/bash

# Install Rancher for work environment
brew install --cask rancher

# Copy work environment configurations
cp work.p10k.zsh ~/.p10k.zsh
cp work.zshrc ~/.zshrc

echo "Work environment setup complete!"
