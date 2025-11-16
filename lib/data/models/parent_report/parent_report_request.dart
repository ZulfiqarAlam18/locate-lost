class ParentReportRequest {
  final String childName;
  final String fatherName;
  final String gender;
  final String lostTime; // ISO date string
  final String contactNumber;
  final String emergency;
  final String? placeLost;
  final String? additionalDetails;

  ParentReportRequest({
    required this.childName,
    required this.fatherName,
    required this.gender,
    required this.lostTime,
    required this.contactNumber,
    required this.emergency,
    this.placeLost,
    this.additionalDetails,
  });

  // Return as form-data compatible map for multipart
  Map<String, String> toFormData() {
    return {
      'childName': childName,
      'fatherName': fatherName,
      'gender': gender,
      'lostTime': lostTime,
      'contactNumber': contactNumber,
      'emergency': emergency,
      if (placeLost != null && placeLost!.isNotEmpty) 'placeLost': placeLost!,
      if (additionalDetails != null && additionalDetails!.isNotEmpty) 
        'additionalDetails': additionalDetails!,
    };
  }

  factory ParentReportRequest.fromJson(Map<String, dynamic> json) {
    return ParentReportRequest(
      childName: json['childName'] ?? '',
      fatherName: json['fatherName'] ?? '',
      gender: json['gender'] ?? '',
      lostTime: json['lostTime'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      emergency: json['emergency'] ?? '',
      placeLost: json['placeLost'],
      additionalDetails: json['additionalDetails'],
    );
  }
}
