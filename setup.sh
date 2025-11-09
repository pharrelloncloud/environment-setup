#!/usr/bin/env bash

# This script sets up the development environment by installing necessary requirements

set -euo pipefail

setup_frontend_environment() {
    echo "Starting Frontend environment setup..."

    read -p "Enter the directory where you want to set up the project (default is current directory): " project_dir
    project_dir=${project_dir:-$(pwd)}
    mkdir -p "$project_dir"
    cd "$project_dir"
    echo "Setting up the project in: $project_dir"  

    echo "Updating package lists..."
    sudo apt-get update 

    echo "Installing required packages..."
    sudo apt-get install -y \
        build-essential \
        curl \
        git \
        nodejs \
        npm
    echo "All required packages have been installed."

    npm init -y
    echo "Node.js project initialized." 

    touch index.html script.js style.css
    echo "Basic frontend files created: index.html, script.js, style.css"

    echo "Setting up Git configuration..."
    read -p "Enter your Git user name: " git_user_name
    git config --global user.name "$git_user_name"
    read -p "Enter your Git user email: " git_user_email
    git config --global user.email "$git_user_email"
    echo "Git global configuration set."    

    git init
    echo "Setup complete!"

    echo "Installing required frontend packages..."
    npm install --save-dev live-server
    echo "Frontend packages installed."    

    echo "✅ Development environment setup complete!"
    echo "Project directory: $project_dir"
}

setup_python_environment() {
    echo "Starting Python environment setup..."

    read -p "Enter the directory where you want to set up the project (default is current directory): " project_dir
    project_dir=${project_dir:-$(pwd)}
    mkdir -p "$project_dir"
    cd "$project_dir"
    echo "Setting up the project in: $project_dir"  

    echo "Updating package lists..."
    sudo apt-get update 

    echo "Installing required packages..."
    sudo apt-get install -y \
        build-essential \
        curl \
        git \
        python3 \
        python3-pip \
        virtualenv  
    echo "All required packages have been installed."

    read -p "Enter your Git user name: " git_user_name
    git config --global user.name "$git_user_name"
    read -p "Enter your Git user email: " git_user_email
    git config --global user.email "$git_user_email"
    echo "Git global configuration set."    

    git init
    echo "Setup complete!"

    echo "Creating Python virtual environment..."
    virtualenv venv
    echo "To activate the virtual environment, run 'source venv/bin/activate'."
    echo "Python virtual environment created."

    echo "Installing required Python packages..."
    source venv/bin/activate
    pip install --upgrade pip
    echo "Python packages installed."    

    echo "Development environment setup complete!"
    echo "Project directory: $project_dir"
}

remove-env(){
    read -p "Enter the project directory to remove the environment: " project_dir
    echo "you are about to remove the environment in: $project_dir"
    read -p "Are you sure you want to proceed? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo "Operation cancelled."
        return
    fi
    echo "Removing existing environment..."
    rm -rf $project_dir
    echo "Environment removed."
}

# ==========================
# Main Menu Loop
# ==========================

while true; do
    clear
    echo "======================================"
    echo "               Main Menu              "
    echo "======================================"
    echo "1) Set up Frontend Environment"
    echo "2) Set up Python Environment"
    echo "3) Remove Environment"
    echo "4) Exit"
    echo "======================================"
    read -p "Please select an option (1-4): " choice
    case $choice in
        1)
            setup_frontend_environment
            exit 0
            ;;
        2)
            setup_python_environment
            exit 0
            ;;
            
        3)
            ls -d -- */ .*/
            remove-env
            exit 0
            ;;
        4)
            echo "Exiting the setup script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done
