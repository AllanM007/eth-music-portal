const main = async () => {
    // const [owner, randomPerson] = await hre.ethers.getSigners();
    const musicContractFactory = await hre.ethers.getContractFactory('MusicPortal');
    const musicContract = await musicContractFactory.deploy();
    await musicContract.deployed();
    console.log('Contract address:', musicContract.address);
    
    let musicCount;
    musicCount = await musicContract.getTotalShazams();
    console.log(musicCount.toNumber());
    
    let musicTxn = await musicContract.shazam('https://www.youtube.com/watch?v=O6SeD1xE7NA&ab_channel=VPRecords');
    await musicTxn.wait();

    const [_, randomPerson] = await hre.ethers.getSigners();
    musicTxn = await musicContract.connect(randomPerson).shazam('https://www.youtube.com/watch?v=O6SeD1xE7NA&ab_channel=VPRecords')
    await musicTxn.wait();

    let allMusic = await musicContract.getAllShazams();
    console.log(allMusic);
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