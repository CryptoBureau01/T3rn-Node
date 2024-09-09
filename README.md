# T3rn-Node
T3rn-Node Setup


### Download the Setup Script
To download the setup script, use one of the following commands:

```bash
curl -L -o buro-setup-t3rn-executor.sh https://github.com/CryptoBuroMaster/T3rn-Node/raw/main/buro-setup-t3rn-executor.sh
```


## After downloading the script, make it executable:

```bash
chmod +x buro-setup-t3rn-executor.sh
```

## Run the Script
Execute the script to start the setup process:

```bash
./buro-setup-t3rn-executor.sh
```

Here's how you can add the README content to provide instructions for general settings, private keys, privacy, and network configuration:


### T3RN Executor Setup by CryptoBuro

This guide will help you set up the T3RN Executor with the `buro-setup-t3rn-executor.sh` script. Please follow the instructions carefully.

## GENERAL SETTINGS

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
