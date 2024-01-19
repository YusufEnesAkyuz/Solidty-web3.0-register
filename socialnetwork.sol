// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SocialNetwork {
    address public owner;
    mapping(address => User) public users;

    event UserRegistered(address indexed user);
    event PasswordChanged(address indexed user);

    struct User {
        string username;
        string passwordHash; // Şifre genellikle hashlenmiş bir şekilde saklanır
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Sadece sahip bu fonksiyonu çağırabilir");
        _;
    }

    modifier onlyNotRegistered() {
        require(users[msg.sender].username == "", "Kullanıcı zaten kayıtlı");
        _;
    }

    modifier onlyRegistered() {
        require(bytes(users[msg.sender].username).length > 0, "Kullanıcı kayıtlı değil");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function register(string memory _username, string memory _password) external onlyNotRegistered {
        require(bytes(_username).length > 0, "Kullanıcı adı boş olamaz");
        require(bytes(_password).length > 0, "Şifre boş olamaz");

        users[msg.sender] = User(_username, _password);
        emit UserRegistered(msg.sender);
    }

}