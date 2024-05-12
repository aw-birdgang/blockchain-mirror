const { ethers } = require("hardhat");

async function main() {
    // Deploying the TrustedForwarder
    const TrustedForwarder = await ethers.getContractFactory("TrustedForwarder");
    const trustedForwarder = await TrustedForwarder.deploy();
    await trustedForwarder.deployed();
    console.log("TrustedForwarder deployed to:", trustedForwarder.address);

    // Deploying the LotteryTicketSales
    const LotteryTicketSales = await ethers.getContractFactory("LotteryTicketSales");
    const lotteryTicketSales = await LotteryTicketSales.deploy(trustedForwarder.address);
    await lotteryTicketSales.deployed();
    console.log("LotteryTicketSales deployed to:", lotteryTicketSales.address);
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});
