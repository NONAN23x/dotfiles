#!/bin/bash

# Function to check and install dependencies
check_and_install_dependencies() {
    # Check if dependencies file exists
    local dependencies_file="dependencies.txt"
    if [ ! -e "$dependencies_file" ]; then
        echo "Dependencies file $dependencies_file not found. Skipping dependency check."
        return
    fi

    # Read dependencies from file
    local dependencies=()
    while IFS= read -r line; do
        dependencies+=("$line")
    done < "$dependencies_file"

    # Check if dependencies are installed
    missing_dependencies=()
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            missing_dependencies+=("$dep")
        fi
    done

    # Install missing dependencies if any
    if [ "${#missing_dependencies[@]}" -gt 0 ]; then
        read -p "The following dependencies are missing: ${missing_dependencies[*]}. Do you want to install them? (y/n): " answer
        if [ "$answer" == "y" ]; then
            # Install missing dependencies
            # For example: sudo apt install "${missing_dependencies[@]}"
            echo "Installing dependencies: ${missing_dependencies[*]}"
            paru -Syu ${missing_dependencies[*]}
        else
            echo "Skipping installation of dependencies."
        fi
    else
        echo "All dependencies are already installed."
    fi
}

# Function to create a backup of existing config files
backup_config() {
    if [ -d ~/.config/ ]; then
        cp -r ~/.config/ ~/.config_backup/
        echo "Backup created at ~/.config_backup"
    else
        echo "No existing config directory found. Skipping backup."
    fi
}

# Function to copy config files to home directory
copy_config_files() {
    if [ -d "$(pwd)/config/" ]; then
        read -p "Do you want to copy config files? (y/n): " answer
        if [ "$answer" == "y" ]; then
            cp -r "$(pwd)/config/"* ~/.config/
            echo "Installed dotfiles to config"
        else
            echo "Skipping copying config files."
        fi
    else
        echo "Config directory not found. Skipping copy."
    fi
}

# Function to copy scripts to home directory
copy_scripts() {
    if [ -d "$(pwd)/scripts/" ]; then
        read -p "Do you want to copy scripts? (y/n): " answer
        if [ "$answer" == "y" ]; then
            mkdir -p ~/.scripts/
            cp -r "$(pwd)/scripts/"* ~/.scripts/
            echo "Installed necessary scripts"
        else
            echo "Skipping copying scripts."
        fi
    else
        echo "Scripts directory not found. Skipping copy."
    fi
}

# Function to setup zsh configuration
setup_zsh_configuration() {
    # Copy .zshrc
    if [ -e .zshrc ]; then
        cp .zshrc ~/.zshrc
        echo "Copied .zshrc to home directory"
    else
        echo ".zshrc file not found. Skipping copy."
    fi

    # installing oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Clone repositories
    cd ~/.oh-my-zsh/custom/plugins

    git clone https://github.com/zsh-users/zsh-autosuggestions.git
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    echo "Cloned repositories."

}


# Main function to execute all setup tasks
main() {
    check_and_install_dependencies
    backup_config
    copy_config_files
    copy_scripts
    setup_zsh_configuration
}

# Call the setup function to execute all tasks
main
