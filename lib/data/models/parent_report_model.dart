import 'package:locate_lost/data/models/user_model.dart';

class ParentReport {
  final String id;
  final String childName;
  final int age;
  final String gender;
  final String placeLost;
  final DateTime lostTime;
  final String status;
  final String? clothes;
  final String? additionalDetails;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final List<ReportImage> images;
  final User? parent;
  final DateTime createdAt;
  final DateTime updatedAt;

  ParentReport({
    required this.id,
    required this.childName,
    required this.age,
    required this.gender,
    required this.placeLost,
    required this.lostTime,
    required this.status,
    this.clothes,
    this.additionalDetails,
    this.latitude,
    this.longitude,
    this.locationName,
    required this.images,
    this.parent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParentReport.fromJson(Map<String, dynamic> json) {
    return ParentReport(
      id: json['id'] ?? '',
      childName: json['childName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      placeLost: json['placeLost'] ?? '',
      lostTime: DateTime.parse(json['lostTime']),
      status: json['status'] ?? 'ACTIVE',
      clothes: json['clothes'],
      additionalDetails: json['additionalDetails'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      locationName: json['locationName'],
      images: (json['images'] as List<dynamic>? ?? [])
          .map((img) => ReportImage.fromJson(img))
          .toList(),
      parent: json['parent'] != null ? User.fromJson(json['parent']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ReportImage {
  final String id;
  final String imageUrl;
  final String? thumbnailUrl;

  ReportImage({
    required this.id,
    required this.imageUrl,
    this.thumbnailUrl,
  });

  factory ReportImage.fromJson(Map<String, dynamic> json) {
    return ReportImage(
      id: json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}