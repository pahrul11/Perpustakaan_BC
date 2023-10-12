// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.20;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract Perpus is Ownable {
    using Math for uint256;

    mapping(uint => BookDetail) public listOfBooks; //isbn => book detail

    struct BookDetail {
        uint isbn; //index (primary key/kunci utama)
        string title;
        uint256 yearBookCreated; //format unix timestamp
        string writerName;
        address writerAddress;
    }

    event BookCreated(uint indexed isbn, address indexed sender, uint256 timestamp);
    event BookUpdated(uint indexed isbn, address indexed sender, uint256 timestamp);
    event BookDeleted(uint indexed isbn, address indexed sender, uint256 timestamp);

    constructor() Ownable(msg.sender){
    }



    //tambah buku
    function tambahBuku(
        uint _isbn,
        string memory _title,
        uint256 _yearBookCreated,
        string memory _writerName,
        address _writerAddress
    ) public onlyOwner(){
        listOfBooks[_isbn] = BookDetail(_isbn, _title, _yearBookCreated, _writerName, _writerAddress);

        emit BookCreated(_isbn, msg.sender, block.timestamp);

    }

    //hapus buku
    function hapusBuku(uint _isbn) public onlyOwner(){
        listOfBooks[_isbn] = BookDetail(0, string(""), 0, string(""), address(0));

        emit BookDeleted(_isbn, msg.sender, block.timestamp);
    }

    //get buku by isbn
    function getBuku(uint _isbn) public view returns 
    (        
        uint __isbn,
        string memory __title,
        uint256 __yearBookCreated,
        string memory __writerName,
        address __writerAddress
    ){

        __isbn = listOfBooks[_isbn].isbn;
        __title = listOfBooks[_isbn].title;
        __yearBookCreated = listOfBooks[_isbn].yearBookCreated;
        __writerName = listOfBooks[_isbn].writerName;
        __writerAddress = listOfBooks[_isbn].writerAddress;

        return(__isbn, __title, __yearBookCreated, __writerName, __writerAddress);
    }

    //update
    function updateTitleBuku(uint _isbn, string memory _title) public onlyOwner(){
        listOfBooks[_isbn].title = _title;

        emit BookUpdated(_isbn, msg.sender, block.timestamp);
    }
}