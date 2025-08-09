import {buildModule} from "@nomicfoundation/hardhat-ignition/modules"

export default buildModule("Bank",(m)=>{
    const bank = m.contract("BankContract",["SolidityBank","soliditybank@gmail.com"])
    return {bank}
})

