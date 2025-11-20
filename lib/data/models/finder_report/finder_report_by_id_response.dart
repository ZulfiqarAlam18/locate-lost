import 'package:locate_lost/utils/constants/endpoints.dart';

// Helper function to fix localhost URLs
String _fixImageUrl(String url) {
  if (url.startsWith('http://localhost:5000/')) {
    final fixedUrl = url.replaceFirst('http://localhost:5000/', Base_URL);
    print('🔧 Fixed localhost URL: $url -> $fixedUrl');
    return fixedUrl;
  }
  // Handle relative URLs
  if (!url.startsWith('http')) {
    final fixedUrl = Base_URL + url;
    print('🔧 Fixed relative URL: $url -> $fixedUrl');
    return fixedUrl;
  }
  return url;
}

class FinderReportByIdResponse {
  final bool success;
  final FinderReportByIdData data;

  FinderReportByIdResponse({
    required this.success,
    required this.data,
  });

  factory FinderReportByIdResponse.fromJson(Map<String, dynamic> json) {
    return FinderReportByIdResponse(
      success: json['success'] ?? false,
      data: FinderReportByIdData.fromJson(json['data'] ?? {}),
    );
  }
}

class FinderReportByIdData {
  final FinderReportDetail report;

  FinderReportByIdData({
    required this.report,
  });

  factory FinderReportByIdData.fromJson(Map<String, dynamic> json) {
    return FinderReportByIdData(
      report: FinderReportDetail.fromJson(json['report'] ?? {}),
    );
  }
}

class FinderReportDetail {
  final String id;
  final String? childName;
  final String? fatherName;
  final String? placeFound;
  final String? gender;
  final String foundTime;
  final String? additionalDetails;
  final String? contactNumber;
  final String? emergency;
  final String status;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final String createdAt;
  final String updatedAt;
  final List<DetailedReportImage> images;
  final FinderUserInfo finder;
  final List<MatchInfo> matchesAsFinder;

  FinderReportDetail({
    required this.id,
    this.childName,
    this.fatherName,
    this.placeFound,
    this.gender,
    required this.foundTime,
    this.additionalDetails,
    this.contactNumber,
    this.emergency,
    required this.status,
    this.latitude,
    this.longitude,
    this.locationName,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.finder,
    required this.matchesAsFinder,
  });

  factory FinderReportDetail.fromJson(Map<String, dynamic> json) {
    return FinderReportDetail(
      id: json['id'] ?? '',
      childName: json['childName'],
      fatherName: json['fatherName'],
      placeFound: json['placeFound'],
      gender: json['gender'],
      foundTime: json['foundTime'] ?? '',
      additionalDetails: json['additionalDetails'],
      contactNumber: json['contactNumber'],
      emergency: json['emergency'],
      status: json['status'] ?? 'ACTIVE',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      locationName: json['locationName'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => DetailedReportImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      finder: FinderUserInfo.fromJson(json['finder'] ?? {}),
      matchesAsFinder: (json['matchesAsFinder'] as List<dynamic>?)
              ?.map((e) => MatchInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class DetailedReportImage {
  final String id;
  final String imageUrl;
  final String? fileName;
  final String createdAt;

  DetailedReportImage({
    required this.id,
    required this.imageUrl,
    this.fileName,
    required this.createdAt,
  });

  factory DetailedReportImage.fromJson(Map<String, dynamic> json) {
    final originalUrl = json['imageUrl'] ?? '';
    final fixedUrl = _fixImageUrl(originalUrl);

    return DetailedReportImage(
      id: json['id'] ?? '',
      imageUrl: fixedUrl,
      fileName: json['fileName'],
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class FinderUserInfo {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? profileImage;

  FinderUserInfo({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.profileImage,
  });

  factory FinderUserInfo.fromJson(Map<String, dynamic> json) {
    String? profileImageUrl;
    if (json['profileImage'] != null) {
      profileImageUrl = _fixImageUrl(json['profileImage']);
    }

    return FinderUserInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      phone: json['phone'],
      email: json['email'],
      profileImage: profileImageUrl,
    );
  }
}

class MatchInfo {
  final String id;
  final double matchConfidence;
  final String status;
  final bool notificationSent;
  final String? notes;
  final String createdAt;
  final String updatedAt;
  final ParentCaseBasic parentCase;

  MatchInfo({
    required this.id,
    required this.matchConfidence,
    required this.status,
    required this.notificationSent,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.parentCase,
  });

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    return MatchInfo(
      id: json['id'] ?? '',
      matchConfidence: (json['matchConfidence'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'PENDING',
      notificationSent: json['notificationSent'] ?? false,
      notes: json['notes'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      parentCase: ParentCaseBasic.fromJson(json['parentCase'] ?? {}),
    );
  }
}

class ParentCaseBasic {
  final String id;
  final String childName;
  final String fatherName;
  final String? gender;
  final String lostTime;
  final String? placeLost;
  final String status;
  final List<DetailedReportImage> images;

  ParentCaseBasic({
    required this.id,
    required this.childName,
    required this.fatherName,
    this.gender,
    required this.lostTime,
    this.placeLost,
    required this.status,
    required this.images,
  });

  factory ParentCaseBasic.fromJson(Map<String, dynamic> json) {
    return ParentCaseBasic(
      id: json['id'] ?? '',
      childName: json['childName'] ?? 'Unknown',
      fatherName: json['fatherName'] ?? 'Unknown',
      gender: json['gender'],
      lostTime: json['lostTime'] ?? '',
      placeLost: json['placeLost'],
      status: json['status'] ?? 'ACTIVE',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => DetailedReportImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
