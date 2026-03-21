#!/usr/bin/env zsh

# Homebrew package installation script
# This script installs all required Homebrew packages and casks

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${RED}Error: Homebrew is not installed.${NC}"
    echo "Please install Homebrew first: https://brew.sh"
    exit 1
fi

echo -e "${GREEN}Starting Homebrew package installation...${NC}\n"

# Regular Homebrew packages
packages=(
    neovim
    1password
    arc
    cursor
    raycast
    ghostty
    granola
    cleanshot
    zoom
    contexts
    slack
    pure
    zsh-syntax-highlighting
    pnpm
    eza
    gh
    karabiner-elements
    descript
    fnm
    fzf
    zoxide
    yt-dlp
    ripgrep
    claude-code
)

# Homebrew casks
casks=(
    jordanbaird-ice
)

# Function to install packages
install_packages() {
    local failed=0
    
    echo -e "${YELLOW}Installing regular packages...${NC}"
    for package in "${packages[@]}"; do
        if brew list "$package" &> /dev/null; then
            echo -e "  ${GREEN}✓${NC} $package (already installed)"
        else
            echo -e "  Installing $package..."
            if brew install "$package"; then
                echo -e "  ${GREEN}✓${NC} $package installed"
            else
                echo -e "  ${RED}✗${NC} Failed to install $package"
                failed=$((failed + 1))
            fi
        fi
    done
    
    return $failed
}

# Function to install casks
install_casks() {
    local failed=0
    
    echo -e "\n${YELLOW}Installing casks...${NC}"
    for cask in "${casks[@]}"; do
        if brew list --cask "$cask" &> /dev/null; then
            echo -e "  ${GREEN}✓${NC} $cask (already installed)"
        else
            echo -e "  Installing $cask..."
            if brew install --cask "$cask"; then
                echo -e "  ${GREEN}✓${NC} $cask installed"
            else
                echo -e "  ${RED}✗${NC} Failed to install $cask"
                failed=$((failed + 1))
            fi
        fi
    done
    
    return $failed
}

# Main installation
main() {
    local package_failures=0
    local cask_failures=0
    
    # Update Homebrew first
    echo -e "${YELLOW}Updating Homebrew...${NC}"
    brew update
    
    # Install packages
    install_packages || package_failures=$?
    
    # Install casks
    install_casks || cask_failures=$?
    
    # Summary
    echo -e "\n${GREEN}Installation complete!${NC}"
    if [ $package_failures -gt 0 ] || [ $cask_failures -gt 0 ]; then
        echo -e "${YELLOW}Some packages failed to install:${NC}"
        [ $package_failures -gt 0 ] && echo -e "  ${RED}$package_failures${NC} regular package(s) failed"
        [ $cask_failures -gt 0 ] && echo -e "  ${RED}$cask_failures${NC} cask(s) failed"
        exit 1
    else
        echo -e "${GREEN}All packages installed successfully!${NC}"
    fi
}

# Run main function
main "$@"
