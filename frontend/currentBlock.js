var Web3 = require('web3');
const web3 = new Web3('https://cloudflare-eth.com');

let latestKnownBlockNumber = -1;
let blockTime = 5000;

function printTransaction(tx) {
    console.log("Transaction hash: ", tx.transactionHash);
    console.log("Status          : ", (tx.status ? "Success" : "Failure"));
    console.log("Block           : ", tx.blockNumber);
    console.log("From            : ", tx.from);
    console.log("To              : ", tx.to);
    console.log("Value           : ", web3.utils.fromWei(tx.value, 'ether'), " Eth");
    console.log("Transaction fee : ", web3.utils.fromWei(''+(tx.gasUsed * parseInt(tx.gasPrice)), 'ether')+" Eth");
    console.log("Gas price       : ", web3.utils.fromWei(tx.gasPrice, 'ether'), " Eth");
    console.log("Gas limit       : ", tx.gas);
    console.log("Gas used        : ", tx.gasUsed);
    console.log("Nonce           : ", tx.nonce, "\n");
}

async function processBlock(blockNumber) {
    console.log("We process block: " + blockNumber);
    let block = await web3.eth.getBlock(blockNumber);
    console.log("new block: ", block);
    for(const transactionHash of block.transactions) {
        let transaction = await web3.eth.getTransaction(transactionHash);
        let transactionReceipt = await web3.eth.getTransactionReceipt(transactionHash);
        transaction = Object.assign(transaction, transactionReceipt);
        console.log("---------------- TRANSACTION ----------------");
        printTransaction(transaction);
    }
    latestKnownBlockNumber = blockNumber;
}

async function checkCurrentBlock() {
    const currentBlockNumber = await web3.eth.getBlockNumber();
    console.log("Current blockchain top: " + currentBlockNumber, " | Script is at: " + latestKnownBlockNumber);
    while(latestKnownBlockNumber == -1 || currentBlockNumber > latestKnownBlockNumber) {
        await processBlock(latestKnownBlockNumber == -1 ? currentBlockNumber : latestKnownBlockNumber + 1);
    }
    setTimeout(checkCurrentBlock, blockTime);
}

checkCurrentBlock();
