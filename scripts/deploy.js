const hre = require("hardhat");

async function main() {
  const Voting = await hre.ethers.getContractFactory("DecentralizedVoting");
  const voting = await Voting.deploy(); // No arguments now

  await voting.deployed();

  console.log("DecentralizedVoting contract deployed to:", voting.address);
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
