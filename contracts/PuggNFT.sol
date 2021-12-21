pragma solidity ^0.7.6;
pragma abicoder v2;

import "../tokens/contracts/erc-721/ERC721Base.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./interface/IPuggNFT.sol";

contract PuggNFT is IPuggNFT, ERC721Base {
    using SafeMath for uint256;

    function __PuggNFT_init(string memory _name, string memory _symbol, string memory baseURI, string memory contractURI) external initializer {
        _setBaseURI(baseURI);
        __ERC721Lazy_init_unchained();
        __RoyaltiesV2Upgradeable_init_unchained();
        __Context_init_unchained();
        __ERC165_init_unchained();
        __Ownable_init_unchained();
        __ERC721Burnable_init_unchained();
        __Mint721Validator_init_unchained();
        __HasContractURI_init_unchained(contractURI);
        __ERC721_init_unchained(_name, _symbol);
        emit CreatePuggNFT(_msgSender(), _name, _symbol);
    }
    uint256[50] private __gap;

    modifier onlyApprovedForAll() {
        require(isApprovedForAll(owner(), _msgSender()), "caller is not approved");
        _;
    }

    mapping(string => Card) public        cardMap;              //cardType => Card
    mapping(uint => string) public        tokenIdCardTypeMap;   //tokenId => cardType

    function isCardExist (string memory cardtype) public view override returns(bool) {
        return cardMap[cardtype].existed;
    }

    function isCardActive (string memory cardtype) public view override returns(bool) {
        return cardMap[cardtype].active;
    }

    function getCardPoints (string memory cardtype) public view override returns(uint) {
        require(cardMap[cardtype].existed, "card type does not exist");
        return cardMap[cardtype].points;
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public override onlyApprovedForAll {
        super._setTokenURI(tokenId, _tokenURI);
    }
    
    function createCard(string memory cardtype, uint points) public override onlyApprovedForAll {
        require(!cardMap[cardtype].existed, "card type is already used");
        cardMap[cardtype] = Card(points, true, true);
    }

    function deleteCard(string memory cardtype, bool active) public override onlyApprovedForAll {
        require(cardMap[cardtype].existed, "card type does not exist");
        Card storage info = cardMap[cardtype];
        info.active = active;
    }

    //Reset card type information
    function setCard(string memory cardtype, uint points) public override onlyApprovedForAll {
        require(cardMap[cardtype].existed, "card id does not exist");
        Card storage info = cardMap[cardtype];
        info.points = points;
    }

    //After the sale, bind the card ID to the card type
    function setTokenIdCardType(uint tokenId, string memory cartType) public override onlyApprovedForAll {
        tokenIdCardTypeMap[tokenId] = cartType;
    }

    function mintAndTransfer(LibERC721LazyMint.Mint721Data memory data, address to) public override onlyApprovedForAll{
        super.mintAndTransfer(data, to);
    }

    function mintAndTransferSale(LibERC721LazyMint.Mint721Data memory data, address to) public override{
        mintAndTransfer(data, to);
    }
}