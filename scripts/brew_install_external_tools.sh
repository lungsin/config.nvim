#!/usr/bin/env bash

set -e

echo "==================================="
echo "External Tools Setup Script"
echo "==================================="
echo ""

# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew (brew) is not installed!"
    echo ""
    echo "Please install Homebrew first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo ""
    echo "After installation, make sure to add brew to your PATH as instructed."
    exit 1
fi

echo "Homebrew found: $(brew --version | head -n1)"
echo ""

# List of tools to install
tools=(
    "neovim"
    "lazygit"
    "fzf"
    "tree-sitter-cli"
)

echo "Installing external tools..."
echo ""

# Install each tool
for tool in "${tools[@]}"; do
    echo "-> Installing $tool..."
    if brew list "$tool" &> /dev/null; then
        echo "  $tool is already installed"
    else
        brew install "$tool"
        echo "  $tool installed successfully"
    fi
    echo ""
done

echo "==================================="
echo "All tools installed successfully!"
echo "==================================="
