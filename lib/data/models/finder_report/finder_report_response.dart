class FinderReportResponse {
  final bool success;
  final String message;
  final FinderReportData? data;

  FinderReportResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory FinderReportResponse.fromJson(Map<String, dynamic> json) {
    return FinderReportResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null 
        ? FinderReportData.fromJson(json['data']['report'] ?? json['data'])
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class FinderReportData {
  final String caseId;
  final String status;

  FinderReportData({
    required this.caseId,
    required this.status,
  });

  factory FinderReportData.fromJson(Map<String, dynamic> json) {
    return FinderReportData(
      caseId: json['id'] ?? json['caseId'] ?? '',
      status: json['status'] ?? 'ACTIVE',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'status': status,
    };
  }
}
