import { expect } from "chai";
import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers.js";
describe("bank",()=>{

    async function DeployContract(){
        const [owner, otherAccount,addr1,addr2] = await ethers.getSigners();
        const bank = await ethers.getContractFactory("BankContract");
        const Bank = await bank.deploy("MyBlockBank", "owner@example.com");
        await Bank.waitForDeployment();
        console.log("Bank deployed to:", Bank.target); 
        return {owner ,otherAccount,Bank,addr1,addr2}
    }

    describe("Deployment",()=>{
        it("should set right Owner",async()=>{
            const {Bank,owner} = await loadFixture(DeployContract);
            expect(await Bank.owner()).to.equal(owner.address);
        });
        it("should emit BankOpened event with correct args", async () => {
            const [owner] = await ethers.getSigners();
            const bank = await ethers.getContractFactory("BankContract");
            const Bank = await bank.deploy("mybank","mybank@gmail.com")
            await expect(Bank.deploymentTransaction())
                    .to.emit(await Bank.waitForDeployment(),"BankOpened")
                    .withArgs(owner.address,"Bank Opened")
        });
    })
    describe('CreateSuperAccount', () => {
      it("should create a user account",async ()=>{
        const {Bank ,addr1,addr2} = await loadFixture(DeployContract)
        await Bank.CreateSuperAccount("john",15,1234567890,"john@gmail.com");
        const user = await Bank.users(addr1.address)
        console.log(user);
        expect(user.name).to.equal('john');
        expect(user.IsActive).to.equal(true);
      })
    })
    
})