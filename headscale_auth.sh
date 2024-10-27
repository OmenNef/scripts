#!/bin/bash

# Function to handle errors
handle_error() {
    echo -e "\e[31mError: $1\e[0m"  # Red text for errors
    exit 1
}

# Check if headscale is installed
if ! command -v headscale &> /dev/null; then
    handle_error "Headscale is not installed. Please install it and try again."
fi

# Create the user adminhq
echo -e "\e[34mAdding user adminhq...\e[0m"  # Blue text
if headscale users create adminhq; then
    echo -e "\e[32mUser adminhq added successfully.\e[0m"  # Green text
else
    echo -e "\e[33mUser adminhq already exists.\e[0m"  # Yellow text
    read -p "Do you want to delete the existing user and create a new one? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
        echo -e "\e[34mDeleting user adminhq...\e[0m"  # Blue text
        headscale users delete adminhq || handle_error "Failed to delete user adminhq."
        echo -e "\e[34mRe-adding user adminhq...\e[0m"  # Blue text
        headscale users create adminhq || handle_error "Failed to re-add user adminhq."
        echo -e "\e[32mUser adminhq re-added successfully.\e[0m"  # Green text
    elif [[ "$answer" == "n" ]]; then
        handle_error "User adminhq already exists. Exiting."
    else
        handle_error "Invalid option. Exiting."
    fi
fi

# Generate auth key for user adminhq
echo -e "\e[34mGenerating auth key for user adminhq...\e[0m"  # Blue text
AUTH_KEY=$(headscale preauthkeys create --user adminhq 2>&1) || handle_error "Failed to generate auth key. Output: $AUTH_KEY"

# Output message for client connection
echo -e "\e[32mSetup client devices: You can now use the generated key to connect client devices to Headscale. On the client, run:\e[0m"  # Green text
printf "tailscale up --authkey=%s\n" "$AUTH_KEY"  # Use printf for proper output
