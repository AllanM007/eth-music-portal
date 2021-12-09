const main = async () => {
    const musicContractFactory = await hre.ethers.getContractFactory('MusicPortal');
    const musicContract = await musicContractFactory.deploy({
      value: hre.ethers.utils.parseEther('0.1'),
    });
    await musicContract.deployed();
    console.log('Contract address:', musicContract.address);

    /*
    * Get Contract balance
    */
   let contractBalance = await hre.ethers.provider.getBalance(
     musicContract.address
    );
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );
    
    let musicTxn = await musicContract.shazam('https://www.youtube.com/watch?v=O6SeD1xE7NA&ab_channel=VPRecords');
    await musicTxn.wait();

    let musicTxn2 = await musicContract.shazam('https://www.youtube.com/watch?v=gP0I3GgfwGc&ab_channel=VybzKartelVEVO');
    await musicTxn2.wait();

    /*
    * Get Contract balance to see what happened!
    */
   contractBalance = await hre.ethers.provider.getBalance(musicContract.address);
   console.log(
     'Contract balance:',
     hre.ethers.utils.formatEther(contractBalance)
    )

    let allShazams = await musicContract.getAllShazams();
    console.log(allShazams);
};
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();