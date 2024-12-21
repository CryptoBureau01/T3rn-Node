# T3rn-Node
T3rn-Node Setup

### Summary of the README

- **Create and Navigate to Directory**: Instructions for creating a directory and navigating into it.
- **Download the Setup Script**: Command to download and make the setup script executable.
- **Run the Setup Script**: Command to execute the setup script.
- **General Settings**: Environment variables for node setup and logging.
- **Private Keys**: Instructions for setting up private keys.
- **Executor Privacy**: Note on privacy and security.
- **Networks & RPC**: Instructions for specifying networks and custom RPC URLs.

Make sure to update the `README.md` file in your GitHub repository with this information.


## General Instructions

Follow these steps to set up the T3rn Node Executor on your Ubuntu system.

### 1. Create and Navigate to the Directory

To download the setup script, use one of the following commands:

```bash
curl -L -o buro-t3rn.sh https://github.com/CryptoBureau01/T3rn-Node/raw/main/t3rn.sh && chmod +x t3rn.sh && ./t3rn.sh
```

### 2. Check Your Node in screen Session

Create a new screen session with a name, e.g., t3rn-node:

```bash
screen -r t3rn
```

Here's how you can add the README content to provide instructions for general settings, private keys, privacy, and network configuration:


This guide will help you set up the T3RN Executor with the `t3rn.sh` script. Please follow the instructions carefully.

### 3 GENERAL SETTINGS

1. Set your preferred Node Environment. 
   Example: export NODE_ENV
   
   ```bash
   testnet
   ```

## PRIVATE KEYS

1. Set the `PRIVATE_KEY_LOCAL` variable of your Executor, which is the private key of the wallet you will use. The example below is a fake generated key that should **not** be used in production:

## Executor Privacy

Read more about [Executor Privacy and Security](https://docs.t3rn.io/executor/become-an-executor/binary-setup) to ensure your setup is secure and private.

## NETWORKS & RPC

1. **Add your preferred networks to operate on.**  
   Example: export ENABLED_NETWORKS
   
   ```bash
   arbitrum-sepolia,base-sepolia,optimism-sepolia,l1rn
   ```




For more detailed information and advanced configurations, refer to the [T3RN Executor Setup Guide](https://docs.t3rn.io/executor/become-an-executor/binary-setup).


You can include this content in your GitHub repository README to guide users through setting up and configuring the T3RN Executor.
