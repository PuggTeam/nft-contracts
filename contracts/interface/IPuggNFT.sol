pragma solidity ^0.7.6;
pragma abicoder v2;
import "@rarible/lazy-mint/contracts/erc-721/LibERC721LazyMint.sol";

interface IPuggNFT {

    event CreatePuggNFT(address indexed operator, string name, string symbol);
    event CreateCard(address indexed operator, string cardtype, uint points);
    event DeleteCard(address indexed operator, string cardtype, bool active);
    event SetCard(address indexed operator, string cardtype, uint points);

    
    struct Card {
        uint        points;         //calit token
        bool        active;
        bool        existed;        //sign for create
    }

    function isCardExist(string memory cardtype) external view returns(bool);
    function isCardActive(string memory cardtype) external view returns(bool);
    function getCardPoints(string memory cardtype) external view returns(uint);
    function createCard(string memory cardtype, uint points) external;
    function deleteCard(string memory cardtype, bool active) external;
    function setCard(string memory cardtype, uint points) external;
    function mintAndTransferSale(LibERC721LazyMint.Mint721Data memory data, address to) external;
}
