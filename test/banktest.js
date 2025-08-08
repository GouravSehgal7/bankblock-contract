import { expect } from "chai";
import hre  from "hardhat";
import { loadFixture} from "@nomicfoundation/hardhat-toolbox/network-helpers";
describe("bank",()=>{

    async function DeployContract(){
        const [owner, otherAccount] = await ethers.getSigners();
        const bank = await ethers.getContractFactory("bank");
        const Bank = await Bank.deploy("MyBlockBank", "owner@example.com");
        await Bank.deployed();
        console.log("Bank deployed to:", Bank.address);
        return {owner ,otherAccount,Bank}
    } 


    it("test",()=>{
         
    })



})