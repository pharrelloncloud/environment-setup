#!/usr/bin/env bash

# This script sets up the development environment by installing necessary requirements

set -euo pipefail

# asks client for where to set up the project
read -p "Enter the directory where you want to set up the project (default is current directory): " project_dir
project_dir=${project_dir:-$(pwd)}
mkdir -p "$project_dir"
cd "$project_dir"
echo "Setting up the project in: $project_dir"  

# Update and install dependencies
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

# Set up a Git environment
read -p "Enter your Git user name: " git_user_name
git config --global user.name "$git_user_name"
read -p "Enter your Git user email: " git_user_email
git config --global user.email "$git_user_email"
echo "Git global configuration set."    
git init
echo "Setup complete!"

# Create a Python virtual environment
echo "Creating a Python virtual environment..."
virtualenv venv
echo "To activate the virtual environment, run 'source venv/bin/activate'."
echo "Python virtual environment created."

# Install Python packages
echo "Installing required Python packages..."
source venv/bin/activate
pip install --upgrade pip
echo "Required Python packages have been installed."    
echo "Development environment setup is complete!"

# Final message
echo "You can now start developing your project!"   
