class ParentReportResponse {
  final bool success;
  final String message;
  final ParentReportData? data;

  ParentReportResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ParentReportResponse.fromJson(Map<String, dynamic> json) {
    return ParentReportResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ParentReportData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ParentReportData {
  final String caseId;
  final String status;

  ParentReportData({required this.caseId, required this.status});

  factory ParentReportData.fromJson(Map<String, dynamic> json) {
    return ParentReportData(
      caseId: json['caseId']?.toString() ?? json['id']?.toString() ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caseId': caseId,
      'status': status,
    };
  }
}
