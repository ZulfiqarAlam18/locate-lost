import 'package:locate_lost/data/models/parent_report_model.dart';
import 'package:locate_lost/data/models/user_model.dart';

class FinderReport {
  final String id;
  final String? childName;
  final int? estimatedAge;
  final String gender;
  final String placeFound;
  final DateTime foundTime;
  final String status;
  final String? clothes;
  final String? additionalDetails;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final List<ReportImage> images;
  final User? finder;
  final DateTime createdAt;

  FinderReport({
    required this.id,
    this.childName,
    this.estimatedAge,
    required this.gender,
    required this.placeFound,
    required this.foundTime,
    required this.status,
    this.clothes,
    this.additionalDetails,
    this.latitude,
    this.longitude,
    this.locationName,
    required this.images,
    this.finder,
    required this.createdAt,
  });

  factory FinderReport.fromJson(Map<String, dynamic> json) {
    return FinderReport(
      id: json['id'] ?? '',
      childName: json['childName'],
      estimatedAge: json['estimatedAge'],
      gender: json['gender'] ?? '',
      placeFound: json['placeFound'] ?? '',
      foundTime: DateTime.parse(json['foundTime']),
      status: json['status'] ?? 'ACTIVE',
      clothes: json['clothes'],
      additionalDetails: json['additionalDetails'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      locationName: json['locationName'],
      images: (json['images'] as List<dynamic>? ?? [])
          .map((img) => ReportImage.fromJson(img))
          .toList(),
      finder: json['finder'] != null ? User.fromJson(json['finder']) : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}