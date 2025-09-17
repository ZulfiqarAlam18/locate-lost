import 'package:locate_lost/data/models/finder_report_model.dart';
import 'package:locate_lost/data/models/parent_report_model.dart';
import 'package:locate_lost/data/models/user_model.dart';

class MatchedCase {
  final String id;
  final String parentReportId;
  final String finderReportId;
  final double confidenceScore;
  final String status;
  final String matchType;
  final ParentReport? parentReport;
  final FinderReport? finderReport;
  final User? confirmedBy;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  MatchedCase({
    required this.id,
    required this.parentReportId,
    required this.finderReportId,
    required this.confidenceScore,
    required this.status,
    required this.matchType,
    this.parentReport,
    this.finderReport,
    this.confirmedBy,
    this.confirmedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MatchedCase.fromJson(Map<String, dynamic> json) {
    return MatchedCase(
      id: json['id'] ?? '',
      parentReportId: json['parentReportId'] ?? '',
      finderReportId: json['finderReportId'] ?? '',
      confidenceScore: (json['confidenceScore'] ?? 0).toDouble(),
      status: json['status'] ?? 'PENDING',
      matchType: json['matchType'] ?? 'AI_MATCH',
      parentReport: json['parentReport'] != null 
        ? ParentReport.fromJson(json['parentReport']) 
        : null,
      finderReport: json['finderReport'] != null 
        ? FinderReport.fromJson(json['finderReport']) 
        : null,
      confirmedBy: json['confirmedBy'] != null 
        ? User.fromJson(json['confirmedBy']) 
        : null,
      confirmedAt: json['confirmedAt'] != null 
        ? DateTime.parse(json['confirmedAt']) 
        : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}