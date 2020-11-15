if (window.ethereum != null) {
    state.web3 = new Web3(window.ethereum)
    try {
        await window.ethereum.enable()
        // Accounts now exposed
    } catch (error) {
        // User denied access
    }
}
