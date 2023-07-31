pragma solidity ^0.8.0;

contract Lottery {

  address public manager;
  address[] public players;
  uint256 public ticketPrice;
  uint256 public winner;

  constructor(uint256 _ticketPrice) {
    manager = msg.sender;
    ticketPrice = _ticketPrice;
  }

  function buyTicket() public payable {
    require(msg.value == ticketPrice, "Ticket price must be equal to the specified price");
    players.push(msg.sender);
  }

  function getWinner() public view returns(address) {
    return winner;
  }

  function random() private view returns(uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp, players)));
  }

  function selectWinner() public {
    winner = players[random() % players.length];
  }

}

