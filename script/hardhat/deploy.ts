import * as hre from 'hardhat';
import { TokenDeployer__factory } from '../../typechain-types';

async function main() {
  const defaultSigner = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
  const deployerSender = new TokenDeployer__factory(await hre.ethers.getSigner(defaultSigner));
  const deployer = await deployerSender.deploy();
  console.log('deployed at', await deployer.deployTransaction.wait());

  const n = 3;
  for (let i = 0; i < n; i ++) {
    const receipt = await deployer.newERC721("token" + i, "TKN" + i)
      .then(tx => tx.wait());
    console.log(receipt);
    await Promise.resolve(setTimeout(() => {}, 200)); // wait for calc
  }
  for (let i = 0; i < n; i ++) {
    const receipt = await deployer.newERC20("token" + i, "TKN" + i)
      .then(tx => tx.wait());
    console.log(receipt);
    await Promise.resolve(setTimeout(() => {}, 200)); // wait for calc
  }
  console.log('token' + 0 + '-' + n, 'deployed');
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
