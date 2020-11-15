const Web3 = require('web3')
const web3 = new Web3('http://localhost:8545')

async function getBlockNumber() {
    const latestBlockNumber = await web3.eth.getBlockNumber();
    console.log(latestBlockNumber);
    return (latestBlockNumber);
}

getBlockNumber();
