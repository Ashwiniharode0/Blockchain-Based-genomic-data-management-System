// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;
contract AccessControl {
    mapping(address => bool) private doctors;
    mapping(address => mapping(address => bool)) private permissions;
    event DoctorAdded(address doctor);
    event PermissionGranted(address patient, address requester);
    event PermissionRevoked(address patient, address requester);
    constructor() {       doctors[msg.sender] = true;    }
 modifier onlyDoctor() {
        require(doctors[msg.sender], "Unauthorized");
        _;
    }
function addDoctor(address _doctor) public onlyDoctor {
        doctors[_doctor] = true;
        emit DoctorAdded(_doctor);
    }
    function grantPermission(address _patient, address _requester) public onlyDoctor {
        permissions[_patient][_requester] = true;
        emit PermissionGranted(_patient, _requester);
    }
    function revokePermission(address _patient, address _requester) public onlyDoctor {
        permissions[_patient][_requester] = false;
        emit PermissionRevoked(_patient, _requester);
    }
    function hasAccess(address _requester, address _patient) public view returns (bool) {
        return doctors[_requester] || permissions[_patient][_requester];
    }
}

