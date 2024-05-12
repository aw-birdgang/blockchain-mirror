// src/blockchain/blockchain.service.ts

import { Injectable } from '@nestjs/common';
import Web3 from 'web3';
import { Contract } from 'web3-eth-contract';

@Injectable()
export class BlockchainService {
  private web3: Web3;
  private lotteryContract: Contract;
  private trustedForwarderContract: Contract;

  constructor() {
    this.web3 = new Web3('https://rinkeby.infura.io/v3/YOUR_INFURA_KEY');
    this.initContracts();
  }

  private initContracts() {
    const lotteryContractAbi = require('../contracts/LotteryTicketSales.json');
    const trustedForwarderContractAbi = require('../contracts/TrustedForwarder.json');

    this.lotteryContract = new this.web3.eth.Contract(
        lotteryContractAbi,
        'YOUR_LOTTERY_CONTRACT_ADDRESS',
    );

    this.trustedForwarderContract = new this.web3.eth.Contract(
        trustedForwarderContractAbi,
        'YOUR_TRUSTED_FORWARDER_ADDRESS',
    );
  }

  async buyTicket(userAddress: string, ticketNumber: number): Promise<string> {
    const data = this.lotteryContract.methods.buyTicket(ticketNumber).encodeABI();

    // Create a transaction object for the forwarder
    const tx = {
      from: userAddress,
      to: this.trustedForwarderContract.options.address,  // Change to forwarder address
      data: this.trustedForwarderContract.methods.forward(
          this.lotteryContract.options.address,
          data
      ).encodeABI(),  // Encapsulate the original transaction data within the forward method call
      gasPrice: await this.web3.eth.getGasPrice(),
      gas: 2000000,
    };

    const signedTx = await this.web3.eth.accounts.signTransaction(tx, 'PRIVATE_KEY_OF_THE_SPONSOR');
    const receipt = await this.web3.eth.sendSignedTransaction(signedTx.rawTransaction);
    return receipt.transactionHash;
  }
}
