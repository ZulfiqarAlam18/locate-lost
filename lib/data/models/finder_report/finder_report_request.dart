class FinderReportRequest {
  final String? childName;
  final String? fatherName;
  final String? gender;
  final String? foundTime; // ISO date string
  final String? contactNumber;
  final String? emergency;
  final String? placeFound;
  final String? additionalDetails;

  FinderReportRequest({
    this.childName,
    this.fatherName,
    this.gender,
    this.foundTime,
    this.contactNumber,
    this.emergency,
    this.placeFound,
    this.additionalDetails,
  });

  // Return as form-data compatible map for multipart
  Map<String, String> toFormData() {
    return {
      if (childName != null && childName!.isNotEmpty) 'childName': childName!,
      if (fatherName != null && fatherName!.isNotEmpty) 'fatherName': fatherName!,
      if (gender != null && gender!.isNotEmpty) 'gender': gender!,
      if (foundTime != null && foundTime!.isNotEmpty) 'foundTime': foundTime!,
      if (contactNumber != null && contactNumber!.isNotEmpty) 'contactNumber': contactNumber!,
      if (emergency != null && emergency!.isNotEmpty) 'emergency': emergency!,
      if (placeFound != null && placeFound!.isNotEmpty) 'placeFound': placeFound!,
      if (additionalDetails != null && additionalDetails!.isNotEmpty) 
        'additionalDetails': additionalDetails!,
    };
  }

  factory FinderReportRequest.fromJson(Map<String, dynamic> json) {
    return FinderReportRequest(
      childName: json['childName'],
      fatherName: json['fatherName'],
      gender: json['gender'],
      foundTime: json['foundTime'],
      contactNumber: json['contactNumber'],
      emergency: json['emergency'],
      placeFound: json['placeFound'],
      additionalDetails: json['additionalDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (childName != null) 'childName': childName,
      if (fatherName != null) 'fatherName': fatherName,
      if (gender != null) 'gender': gender,
      if (foundTime != null) 'foundTime': foundTime,
      if (contactNumber != null) 'contactNumber': contactNumber,
      if (emergency != null) 'emergency': emergency,
      if (placeFound != null) 'placeFound': placeFound,
      if (additionalDetails != null) 'additionalDetails': additionalDetails,
    };
  }
}
