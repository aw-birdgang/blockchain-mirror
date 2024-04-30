# setup
````
npm init
npm install hardhat

````


# init
````
npx hardhat

````


# build & deploy & verify
````

> npx hardhat compile
> npx hardhat run scripts/deploy-lotto.js --network sepolia

LotteryTicketContract deployed to: 0x21224897a776A0d9777564e27fdcAc5Cf8A66e7e
PaymasterContract deployed to: 0x3db9a72f276afAc20458F5ef30552B65396aB8bC


npx hardhat verify --network sepolia 0x21224897a776A0d9777564e27fdcAc5Cf8A66e7e --contract contracts/LOTTERY_TICKET.sol:LotteryTicketContract
npx hardhat verify --network sepolia 0x3db9a72f276afAc20458F5ef30552B65396aB8bC --contract contracts/PAYMASTER_CONTRACT.sol:PaymasterContract "0x21224897a776A0d9777564e27fdcAc5Cf8A66e7e"


https://sepolia.etherscan.io/address/0x21224897a776A0d9777564e27fdcAc5Cf8A66e7e
https://sepolia.etherscan.io/address/0x21224897a776A0d9777564e27fdcAc5Cf8A66e7e#code

https://sepolia.etherscan.io/address/0x3db9a72f276afAc20458F5ef30552B65396aB8bC
https://sepolia.etherscan.io/address/0x3db9a72f276afAc20458F5ef30552B65396aB8bC#code





# 지원 네트워크 목록
npx hardhat verify --list-networks
````


# test

````

````


# token
```` 



````




