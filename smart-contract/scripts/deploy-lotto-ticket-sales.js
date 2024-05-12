const hre = require("hardhat");

async function main() {
    const LotteryTicket = await hre.ethers.getContractFactory("LotteryTicketContract");
    const lotteryTicket = await LotteryTicket.deploy();

    await lotteryTicket.deployed();

    console.log("LotteryTicketContract deployed to:", lotteryTicket.address);

    const Paymaster = await hre.ethers.getContractFactory("PaymasterContract");
    const paymaster = await Paymaster.deploy(lotteryTicket.address);

    await paymaster.deployed();

    console.log("PaymasterContract deployed to:", paymaster.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
