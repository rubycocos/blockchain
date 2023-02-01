/*
 fix error with parsing _contract
 */

///////////////////////////////////////////
// File: /contracts/Moonbirds.sol

pragma solidity >=0.8.10 <0.9.0;


contract Moonbirds {
function setRenderingContract(ITokenURIGenerator _contract)
        external
        onlyOwner
    {
        renderingContract = _contract;
    }
}


