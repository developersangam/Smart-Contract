pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public payable{
        require(msg.value >0.01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint){
        //here "block.diffuclty" is nounce and "now" is current time. This are global variable is solidity 
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public restricted{
        uint index;
        index = random()%players.length;
        players[index].transfer(this.balance);
        //For emptying an array syntax
        players = new address[](0);
    }

    //modifier is used to use the same condrion is logic many time in many fucntion 
    modifier restricted() {
        // require is just if condition in javascript
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address[]){
        return players;
    }
}