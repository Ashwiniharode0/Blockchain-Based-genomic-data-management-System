// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;

contract PatientData {
    struct GenomicData {
        string data;
        address patient;
        bool shared;
    }

    mapping(address => GenomicData) private patientDataMap;

    event DataShared(address patient, address doctor);
    event DataRequested(address patient, address requester);

    function addPatientData(string memory _genomicData) public {
        require(bytes(_genomicData).length > 0, "Genomic data cannot be empty");
        patientDataMap[msg.sender] = GenomicData(_genomicData, msg.sender, false);
    }

    function getPatientData(address _patient) public view returns (string memory) {
        return patientDataMap[_patient].data;
    }

    function sharePatientData(address _patient) public {
        require(patientDataMap[_patient].patient == msg.sender, "Only patient can share data");
        patientDataMap[_patient].shared = true;
        emit DataShared(_patient, msg.sender);
    }

    function requestPatientData(address _patient) public {
        emit DataRequested(_patient, msg.sender);
    }
}
