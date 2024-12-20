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








# Function to display menu and prompt user for input
master() {
    print_info "======================================"
    print_info "    T3RN Executor Node Tool Menu      "
    print_info "======================================"
    print_info ""
    print_info "1. Install-Dependency"
    print_info "2. Setup-Executor"
    print_info "3. "
    print_info "4. "
    print_info "5. "
    print_info "6. "
    print_info "7. "
    print_info "8. "
    print_info "9. "
    print_info ""
    print_info "===================================="
    print_info "     Created By : CB-Master         "
    print_info "===================================="
    print_info ""
    
    read -p "Enter your choice (1 or 3): " user_choice

    case $user_choice in
        1)
            install_dependency
            ;;
        2)
            setup_node
            ;;
        3) 

            ;;
        4)

            ;;
        5)

            ;;
        6)

            ;;
        7)

            ;;
        8)
            exit 0  # Exit the script after breaking the loop
            ;;
        *)
            print_error "Invalid choice. Please enter 1 or 3 : "
            ;;
    esac
}

# Call the uni_menu function to display the menu
master_fun
master
