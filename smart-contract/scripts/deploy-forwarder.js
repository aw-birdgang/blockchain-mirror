const { ethers } = require("hardhat");

async function main() {
    const Forwarder = await ethers.getContractFactory("TrustedForwarder");
    const forwarder = await Forwarder.deploy();
    await forwarder.deployed();
    console.log("TrustedForwarder deployed to:", forwarder.address);

    const MyContract = await ethers.getContractFactory("MyMetaTransactionContract");
    const myContract = await MyContract.deploy(forwarder.address);
    await myContract.deployed();
    console.log("MyMetaTransactionContract deployed to:", myContract.address);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
