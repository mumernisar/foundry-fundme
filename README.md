# Foundry Fund Me

This project is a smart contract for a decentralized funding platform. It uses Foundry for development, testing, and deployment. Below are the basic commands to get started with the project.

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Quickstart

```sh
git clone https://github.com/Cyfrin/mumernisar/funde
cd foundry-fund-me-cu
make
```

# Usage

## Deploy

```sh
make deploy
```

## Testing

```sh
make test
```

```sh
// Only run test functions matching the specified regex pattern.

"forge test -m testFunctionName" is deprecated. Please use

forge test --match-test testFunctionName
```

or

```sh
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```sh
forge coverage
```

## Local zkSync

The instructions here will allow you to work with this repo on zkSync.

### (Additional) Requirements

In addition to the requirements above, you'll need:

- [foundry-zksync](https://github.com/matter-labs/foundry-zksync)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.0.2 (816e00b 2023-03-16T00:05:26.396218Z)`.
- [npx & npm](https://docs.npmjs.com/cli/v10/commands/npm-install)
  - You'll know you did it right if you can run `npm --version` and you see a response like `7.24.0` and `npx --version` and you see a response like `8.1.0`.
- [docker](https://docs.docker.com/engine/install/)
  - You'll know you did it right if you can run `docker --version` and you see a response like `Docker version 20.10.7, build f0df350`.
  - Then, you'll want the daemon running, you'll know it's running if you can run `docker --info` and in the output you'll see something like the following to know it's running:

```bash
Client:
 Context:    default
 Debug Mode: false
```

### Setup local zkSync node

Run the following:

```bash
npx zksync-cli dev config
```

And select: `In memory node` and do not select any additional modules.

Then run:

```bash
npx zksync-cli dev start
```

And you'll get an output like:

```
In memory node started v0.1.0-alpha.22:
 - zkSync Node (L2):
  - Chain ID: 260
  - RPC URL: http://127.0.0.1:8011
  - Rich accounts: https://era.zksync.io/docs/tools/testing/era-test-node.html#use-pre-configured-rich-wallets
```

### Deploy to local zkSync node

```sh
make deploy-zk
```

This will deploy a mock price feed and a fund me contract to the zkSync node.

# Deployment to a testnet or mainnet

1. Setup environment variables

You'll want to set your `SEPOLIA_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com)
- `HOLESKY_RPC_URL`: This is url of the holesky testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com)

Optionally, add your `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

2. Get testnet ETH

Head over to [cloud.google.com/application/web3/faucet](https://cloud.google.com/application/web3/faucet/) and get some testnet ETH. You should see the ETH show up in your metamask.

3. Deploy

```sh
make deploy-sepolia ARGS="--network sepolia"
```

## Scripts

After deploying to a testnet or local net, you can run the scripts.

Using cast deployed locally example:

```sh
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```

or

```sh
make fund
```

### Withdraw

```sh
cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()"  --private-key <PRIVATE_KEY>
```

```sh
make withdraw
```

## Estimate gas

You can estimate how much gas things cost by running:

```sh
make snapshot
```

And you'll get the output in a file called `.gas-snapshot`

# Formatting

To run code formatting:

```sh
make format
```

# Thank you!

If you appreciated this, feel free to see my other projects and contributions are welcome. 💖

```

```
