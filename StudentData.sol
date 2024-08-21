// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {
    struct Student {
        address owner;
        string name;
        string email;
        uint256[] grades;
        bool exists; // To check if the student exists
    }

    // Array to store Student structs
    Student[] public students;

    // Modifier to ensure only the owner can modify their data
    modifier onlyOwner(uint256 _index) {
        require(msg.sender == students[_index].owner, "Only the owner can modify their data");
        _;
    }

    // Function to add a new student
    function addStudentData(string memory _name, string memory _email, uint256[] memory _grades) public {
        // Create a new Student struct and add it to the array
        students.push(Student(msg.sender, _name, _email, _grades, true));
    }

    // Function to update a student's data
    function updateStudentData(uint256 _index, string memory _name, string memory _email, uint256[] memory _grades) public onlyOwner(_index) {
        // Update the student's data at the specified index
        Student storage student = students[_index];
        student.name = _name;
        student.email = _email;
        student.grades = _grades;
    }

    // Function to delete a student's data
    function deleteStudentData(uint256 _index) public onlyOwner(_index) {
        // Remove the student's data at the specified index
        delete students[_index];
    }

    // Function to get student data by index
    function getStudentData(uint256 _index) public view returns (address, string memory, string memory, uint256[] memory) {
        require(students[_index].exists, "Student does not exist");
        Student storage student = students[_index];
        return (student.owner, student.name, student.email, student.grades);
    }
}
