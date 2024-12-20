#!/bin/bash

curl -s https://raw.githubusercontent.com/CryptoBureau01/logo/main/logo.sh | bash
sleep 5

# Welcome message
print_info() {
    echo "$1"
}

# Welcome message
print_info "Welcome to the t3rn Executor Setup by CryptoBuro!"

# Update and upgrade system
print_info "Updating and upgrading the system..."
sudo apt -q update
sudo apt -qy upgrade

# Define variables
EXECUTOR_URL="https://github.com/t3rn/executor-release/releases/download/v0.29.0/executor-linux-v0.29.0.tar.gz"
EXECUTOR_FILE="executor-linux-v0.29.0.tar.gz"

# Download the Executor binary
print_info "Downloading the Executor binary from $EXECUTOR_URL..."
curl -L -o $EXECUTOR_FILE $EXECUTOR_URL

if [ $? -ne 0 ]; then
    print_info "Failed to download the Executor binary. Please check your internet connection and try again."
    exit 1
fi

# Extract the binary
print_info "Extracting the binary..."
tar -xzvf $EXECUTOR_FILE

# Navigate to the binary directory
cd executor/executor/bin

# Set up environment variables
print_info "Setting up environment variables..."
read -p "Enter your preferred Node Environment (e.g., testnet, mainnet): " NODE_ENV
export NODE_ENV=${NODE_ENV:-testnet}
print_info "Node Environment set to: $NODE_ENV"

export LOG_LEVEL=debug
export LOG_PRETTY=false
print_info "Log settings configured: LOG_LEVEL=$LOG_LEVEL, LOG_PRETTY=$LOG_PRETTY"

read -s -p "Enter your Private Key from Metamask: " PRIVATE_KEY_LOCAL
export PRIVATE_KEY_LOCAL=$PRIVATE_KEY_LOCAL
print_info "\nPrivate key has been set."

read -p "Enter the networks to operate on (comma-separated, e.g., arbitrum-sepolia,base-sepolia): " ENABLED_NETWORKS
export ENABLED_NETWORKS=${ENABLED_NETWORKS:-arbitrum-sepolia,base-sepolia,optimism-sepolia,l1rn}
print_info "Enabled Networks set to: $ENABLED_NETWORKS"

read -p "Would you like to set custom RPC URLs? (y/n): " SET_RPC
if [ "$SET_RPC" == "y" ]; then
  for NETWORK in $(echo $ENABLED_NETWORKS | tr "," "\n"); do
    read -p "Enter the RPC URLs for $NETWORK (comma-separated): " RPC_URLS
    export EXECUTOR_${NETWORK^^}_RPC_URLS=$RPC_URLS
    print_info "RPC URLs set for $NETWORK"
  done
else
  print_info "Skipping custom RPC URL setup. Default URLs will be used."
fi

# Start the Executor
print_info "Starting the Executor..."
./executor

print_info "Setup complete! The Executor is now running with CryptoBuro."
