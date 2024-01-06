// scripts/deploy.ts
import { ethers } from "hardhat";

async function main() {
  // Fetch the deployer's address
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Deploy the contract
  const DecentralizedStorage = await ethers.getContractFactory("DecentralizedStorageContract");
  const decentralizedStorage = await DecentralizedStorage.deploy(deployer.address);

  console.log("DecentralizedStorageContract deployed to:", await decentralizedStorage.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
