### Development Environment Setup
- Install ganache-cli `npm install -g ganache-cli`
- Install Truffle `npm install -g truffle`
- Start Local EVM `ganache-cli -p 8545`
- Deploy Smart Contract to EVM `cd token && truffle compile && truffle migrate --network development` compiles and deploys the contract to local EVM