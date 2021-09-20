pragma solidity >=0.7.0 <0.9.0;


contract Bible {

    address owner;

    mapping (uint => string) books;
    mapping (uint => mapping (uint => mapping (uint => string))) bible;
    
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    event BookAdded(uint book);
    event VerseAdded(uint book, uint chapter, uint verse);
    
    constructor() {
        owner = msg.sender;
        emit OwnerSet(address(0), owner);
    }

    function addBook(uint book, string memory name) public {
        require(msg.sender == owner);
        books[book] = name;
        emit BookAdded(book);
    }
    
    function setVerse(uint book, uint chapter, uint verse, string memory text) public {
        require(msg.sender == owner);
        bible[book][chapter][verse] = text;
        emit VerseAdded(book, chapter, verse);
    }

    function getBookName(uint book) public view returns (string memory) {
        return books[book];
    }
    
    function getVerse(uint book, uint chapter, uint verse) public view returns (string memory) {
        return bible[book][chapter][verse];
    }
    
    // ownership
    function setOwner(address newOwner) public {
        require(msg.sender == owner);
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }
    function getOwner() public view returns (address) {
        return owner;
    }
}
