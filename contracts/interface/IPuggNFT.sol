pragma solidity ^0.7.6;
pragma abicoder v2;
import "../../lazy-mint/contracts/erc-721/LibERC721LazyMint.sol";

interface IPuggNFT {

    event CreatePuggNFT(address indexed operator, string name, string symbol);

    
    struct Card {
        uint        points;         //The number of points pledged by the pool to go online
        string      cardURI;        //the URL of card
        bool        active;
        bool        existed;        //sign for create
    }

    function isCardExist(string memory cardtype) external view returns(bool);
    function isCardActive(string memory cardtype) external view returns(bool);
    function getCardPoints(string memory cardtype) external view returns(uint);
    function getCardURI(string memory cardtype) external view returns(string memory);
    function setTokenURI(uint256 tokenId, string memory _tokenURI) external;
    function createCard(string memory cardtype, uint points, string memory cardURI) external;
    function deleteCard(string memory cardtype, bool active) external;
    function setCard(string memory cardtype, uint points, string memory cardURI) external;
    function setTokenIdCardType(uint tokenId, string memory cartType) external;
    function mintAndTransferSale(LibERC721LazyMint.Mint721Data memory data, address to) external;
}
