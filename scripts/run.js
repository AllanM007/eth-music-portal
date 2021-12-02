const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const musicContractFactory = await hre.ethers.getContractFactory('MusicPortal');
    const musicContract = await musicContractFactory.deploy();
    await musicContract.deployed();

    console.log("Contract deployed to:", musicContract.address);
    console.log("Contract deployed by:", owner.address);
    
    let musicCount;
    musicCount = await musicContract.getTotalShazams();
    
    let musicTxn = await musicContract.shazam();
    await musicTxn.wait();
    
    musicCount = await musicContract.getTotalShazams();
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