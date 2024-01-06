// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DecentralizedStorageContract is Ownable {

    constructor(address _owner) Ownable(_owner) {}

    struct FileChunk {
        uint256 chunkId;
        string downloadURL;
    }

    struct File {
        uint256 fileId;
        string fileName;
        uint256[] chunkIds;
    }

    mapping(uint256 => FileChunk) public fileChunks;
    mapping(uint256 => File) public files;

    event FileAdded(uint256 indexed fileId, string fileName);
    event ChunkAdded(uint256 indexed chunkId, uint256 indexed fileId, string downloadURL);

    function addFile(uint256 fileId, string memory fileName) external onlyOwner {
        files[fileId] = File(fileId, fileName, new uint256[](0));
        emit FileAdded(fileId, fileName);
    }

    function addChunk(uint256 fileId, uint256 chunkId, string memory downloadURL) external onlyOwner {
        FileChunk memory newChunk = FileChunk(chunkId, downloadURL);
        fileChunks[chunkId] = newChunk;
        files[fileId].chunkIds.push(chunkId);
        emit ChunkAdded(chunkId, fileId, downloadURL);
    }

    // Function to fetch all chunks of a file, restricted to the owner
    function getChunks(uint256 fileId) external view onlyOwner returns (FileChunk[] memory) {
        File storage file = files[fileId];
        FileChunk[] memory chunks = new FileChunk[](file.chunkIds.length);

        for (uint i = 0; i < file.chunkIds.length; i++) {
            chunks[i] = fileChunks[file.chunkIds[i]];
        }

        return chunks;
    }
}
