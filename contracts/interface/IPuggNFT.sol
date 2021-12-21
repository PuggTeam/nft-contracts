pragma solidity ^0.7.6;
pragma abicoder v2;
import "../../tokens/contracts/rarible/lazy-mint/contracts/erc-721/LibERC721LazyMint.sol";


/*
test tokenByIndex
use diff accounts test onlyApprovedForAll function
tested setCard
tested setTokenIdCardType
tested auth for all function
tested mintAndTransferSale with error tokenId
*/

interface IPuggNFT {

    event CreatePuggNFT(address indexed operator, string name, string symbol);

    
    struct Card {
        uint        points;         //The number of points pledged by the pool to go online
        bool        active;
        bool        existed;        //sign for create
    }

    function isCardExist(string memory cardtype) external view returns(bool);
    function isCardActive(string memory cardtype) external view returns(bool);
    function getCardPoints(string memory cardtype) external view returns(uint);
    function setTokenURI(uint256 tokenId, string memory _tokenURI) external;
    function createCard(string memory cardtype, uint points) external;
    function deleteCard(string memory cardtype, bool active) external;
    function setCard(string memory cardtype, uint points) external;
    function setTokenIdCardType(uint tokenId, string memory cartType) external;
    function mintAndTransferSale(LibERC721LazyMint.Mint721Data memory data, address to) external;
}
