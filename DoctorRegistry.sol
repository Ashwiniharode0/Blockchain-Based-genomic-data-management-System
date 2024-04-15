// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;
contract DoctorRegistry {
    mapping(address => bool) private doctors;
    event DoctorAdded(address doctor);
    function addDoctor(address _doctor) public {
        doctors[_doctor] = true;
        emit DoctorAdded(_doctor);
    }
    function isDoctor(address _doctor) public view returns (bool) {
        return doctors[_doctor];
}
}
