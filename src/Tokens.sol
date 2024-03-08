// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintableERC721 is ERC721Enumerable, Ownable {
    uint256 public next;
    constructor(string memory name, string memory symbol, address owner) ERC721(name, symbol) Ownable(owner) {}

    function mint(address to) external onlyOwner() {
        _mint(to, next);
    }

    function burn(uint256 tokenId) external onlyOwner() {
        _burn(tokenId);
    }
}

contract MintableERC20 is ERC20, Ownable {
    constructor(string memory name, string memory symbol, address owner) ERC20(name, symbol) Ownable(owner) {}

    function mint(address account, uint256 amount) external onlyOwner() {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external onlyOwner() {
        _burn(account, amount);
    }
}

contract TokenDeployer {
    event ERC721Created(address token, uint256 index);
    event ERC20Created(address token, uint256 index);

    address[] private erc721;
    address[] private erc20;

    constructor() {}

    function newERC721(string memory name, string memory symbol) external returns (address) {
        address token = address(new MintableERC721(name, symbol, msg.sender));
        erc721.push(token);
        emit ERC721Created(token, erc721.length);
        return token;
    }

    function erc721ByIndex(uint256 idx) view public returns (address) {
        require(idx < erc721.length, "no contract at the index");
        return erc721[idx];
    }

    function erc721Count() view public returns (uint256) {
        return erc721.length;
    }

    function newERC20(string memory name, string memory symbol) external returns (address) {
        address token = address(new MintableERC20(name, symbol, msg.sender));
        erc20.push(token);
        emit ERC20Created(token, erc20.length);
        return token;
    }

    function erc20ByIndex(uint256 idx) view public returns (address) {
        require(idx < erc20.length, "no contract at the index");
        return erc20[idx];
    }

    function erc20Count() view public returns (uint256) {
        return erc20.length;
    }
}
