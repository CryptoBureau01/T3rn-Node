# !/bin/bash

curl -s https://raw.githubusercontent.com/CryptoBureau01/logo/main/logo.sh | bash
sleep 5

# Function to print info messages
print_info() {
    echo -e "\e[32m[INFO] $1\e[0m"
}

# Function to print error messages
print_error() {
    echo -e "\e[31m[ERROR] $1\e[0m"
}



#Function to check system type and root privileges
master_fun() {
    echo "Checking system requirements..."

    # Check if the system is Ubuntu
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" != "ubuntu" ]; then
            echo "This script is designed for Ubuntu. Exiting."
            exit 1
        fi
    else
        echo "Cannot detect operating system. Exiting."
        exit 1
    fi

    # Check if the user is root
    if [ "$EUID" -ne 0 ]; then
        echo "You are not running as root. Please enter root password to proceed."
        sudo -k  # Force the user to enter password
        if sudo true; then
            echo "Switched to root user."
        else
            echo "Failed to gain root privileges. Exiting."
            exit 1
        fi
    else
        echo "You are running as root."
    fi

    echo "System check passed. Proceeding to package installation..."
}


# Function to install dependencies
install_dependency() {
    print_info "<=========== Install Dependency ==============>"
    print_info "Updating and upgrading system packages, and installing curl..."
    sudo apt -q update && sudo apt upgrade -qy && sudo apt install git wget screen jq curl -y 

    # Call the uni_menu function to display the menu
    master
}


# Setup Node function
setup_node() {
    # Create /root/t3rn folder
    local folder_path="/root/t3rn"

    if [ -d "$folder_path" ]; then
        print_info "The folder '$folder_path' already exists. Exiting..."
        return 0
    else
        mkdir -p "$folder_path"
        print_info "Created folder '$folder_path'."
    fi

    sleep 1
    # Navigate to the folder
    cd "$folder_path" || { print_info "Failed to navigate to $folder_path. Exiting..."; exit 1; }

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

    sleep 1
    # Extract the binary
    print_info "Extracting the binary..."
    tar -xzvf $EXECUTOR_FILE

    if [ $? -ne 0 ]; then
        print_info "Failed to extract the binary. Exiting..."
        exit 1
    fi

    # Final message
    print_info "Successfully set up T3rn Executor Node!"

    # Call the uni_menu function to display the menu
    master
}


# Function to configure the Executor node
configure_node() {
    local folder_path="/root/t3rn"

    # Check if the /root/t3rn folder exists
    if [ ! -d "$folder_path" ]; then
        print_info "The folder '$folder_path' does not exist. Please run the setup_node function first. Exiting..."
        return 1
    fi

    # Navigate to the folder
    cd "$folder_path" || { print_info "Failed to navigate to $folder_path. Exiting..."; exit 1; }

    # Navigate to the binary directory
    if [ ! -d "executor/executor/bin" ]; then
        print_info "The binary directory 'executor/executor/bin' does not exist. Exiting..."
        return 1
    fi
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

    # Custom RPC URL setup
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

    # Call the uni_menu function to display the menu
    master
}


# Function to start the T3rn Executor Node
start_node() {
    # Install screen if not already installed
    if ! command -v screen &> /dev/null; then
        print_info "Installing 'screen' utility..."
        apt update && apt install -y screen
        if [ $? -ne 0 ]; then
            print_info "Failed to install 'screen'. Please install it manually and try again."
            return 1
        fi
        print_info "'screen' has been successfully installed."
    else
        print_info "'screen' is already installed."
    fi

    # Navigate to the binary directory
    local binary_path="/root/t3rn/executor/executor/bin"
    if [ ! -d "$binary_path" ]; then
        print_info "The directory '$binary_path' does not exist. Please run the setup_node function first. Exiting..."
        return 1
    fi

    cd "$binary_path" || { print_info "Failed to navigate to $binary_path. Exiting..."; exit 1; }

    # Start the node in a new screen session
    print_info "Starting the T3rn Executor Node in a new screen session named 't3rn'..."
    screen -dmS t3rn ./executor
    if [ $? -ne 0 ]; then
        print_info "Failed to start the node in a screen session. Please try again."
        return 1
    fi

    # Success message
    print_info "Your node has been successfully started! You can view it using the command: screen -r t3rn"

    # Call the uni_menu function to display the menu
    master
}









# Function to display menu and prompt user for input
master() {
    print_info "======================================"
    print_info "    T3RN Executor Node Tool Menu      "
    print_info "======================================"
    print_info ""
    print_info "1. Install-Dependency"
    print_info "2. Setup-Executor"
    print_info "3. Node-Configure"
    print_info "4. Start-Node"
    print_info "5. Exit"
    print_info ""
    print_info "===================================="
    print_info "     Created By : CB-Master         "
    print_info "===================================="
    print_info ""
    
    read -p "Enter your choice (1 or 5): " user_choice

    case $user_choice in
        1)
            install_dependency
            ;;
        2)
            setup_node
            ;;
        3) 
            configure_node
            ;;
        4)
            start_node
            ;;
        5)
            exit 0  # Exit the script after breaking the loop
            ;;
        *)
            print_error "Invalid choice. Please enter 1 or 5 : "
            ;;
    esac
}

# Call the uni_menu function to display the menu
master_fun
master
