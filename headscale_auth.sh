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
echo -e "\e[34mCreating user adminhq...\e[0m"  # Blue text
headscale users create adminhq || handle_error "Failed to create user adminhq."

# Generate an auth key for user adminhq without the --expiration flag
echo -e "\e[34mGenerating auth key for user adminhq...\e[0m"  # Blue text
AUTH_KEY=$(headscale authkey --user adminhq 2>&1) || handle_error "Failed to generate auth key."

# Check if the key is not empty
if [ -z "$AUTH_KEY" ]; then
    handle_error "Auth key is empty. Please ensure that user adminhq exists."
fi

# Output message for client connection
echo -e "\e[32mConnect the client using the following command:\e[0m"  # Green text
printf "tailscale up --authkey=%s\n" "$AUTH_KEY"  # Use printf for proper output
