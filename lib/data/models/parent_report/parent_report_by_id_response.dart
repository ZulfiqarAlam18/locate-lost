// Response model for GET /api/reports/parent/{reportId} endpoint

import '../../../utils/constants/endpoints.dart';

/// Helper function to fix image URLs
String _fixImageUrl(String url) {
  // If URL is relative or starts with localhost, convert to tunnel URL
  if (url.isEmpty) return url;
  
  if (url.startsWith('http://localhost:5000/')) {
    // Replace localhost with tunnel URL
    final fixed = url.replaceFirst('http://localhost:5000/', Base_URL);
    print('🔧 Fixed localhost URL: $url -> $fixed');
    return fixed;
  } else if (url.startsWith('/')) {
    // If it's a relative URL, prepend Base_URL
    final fixed = Base_URL + url.substring(1); // Remove leading slash since Base_URL has trailing slash
    print('🔧 Fixed relative URL: $url -> $fixed');
    return fixed;
  }
  
  return url; // Already a full URL or empty
}

// Match related classes
class MatchInfo {
  final String id;
  final double matchConfidence;
  final String status;
  final String createdAt;
  final FinderCaseBasic finderCase;

  MatchInfo({
    required this.id,
    required this.matchConfidence,
    required this.status,
    required this.createdAt,
    required this.finderCase,
  });

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    return MatchInfo(
      id: json['id'] ?? '',
      matchConfidence: (json['matchConfidence'] ?? 0.0).toDouble(),
      status: json['status'] ?? 'PENDING',
      createdAt: json['createdAt'] ?? '',
      finderCase: json['finderCase'] != null
          ? FinderCaseBasic.fromJson(json['finderCase'])
          : FinderCaseBasic(id: '', childName: 'Unknown', placeFound: '', foundTime: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matchConfidence': matchConfidence,
      'status': status,
      'createdAt': createdAt,
      'finderCase': finderCase.toJson(),
    };
  }
}

class FinderCaseBasic {
  final String id;
  final String? childName;
  final String? placeFound;
  final String foundTime;

  FinderCaseBasic({
    required this.id,
    this.childName,
    this.placeFound,
    required this.foundTime,
  });

  factory FinderCaseBasic.fromJson(Map<String, dynamic> json) {
    return FinderCaseBasic(
      id: json['id'] ?? '',
      childName: json['childName'],
      placeFound: json['placeFound'],
      foundTime: json['foundTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childName': childName,
      'placeFound': placeFound,
      'foundTime': foundTime,
    };
  }
}

class DetailedReportImage {
  final String id;
  final String imageUrl;
  final String fileName;

  DetailedReportImage({
    required this.id,
    required this.imageUrl,
    required this.fileName,
  });

  factory DetailedReportImage.fromJson(Map<String, dynamic> json) {
    print('📷 Parsing DetailedReportImage from JSON: $json');
    String rawImageUrl = json['imageUrl'] ?? '';
    String imageUrl = _fixImageUrl(rawImageUrl);
    print('📷 Final detailed imageUrl: $imageUrl');
    
    return DetailedReportImage(
      id: json['id'] ?? '',
      imageUrl: imageUrl,
      fileName: json['fileName'] ?? 'image.jpg',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'fileName': fileName,
    };
  }
}

class ParentUserInfo {
  final String id;
  final String name;
  final String phone;
  final String email;

  ParentUserInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory ParentUserInfo.fromJson(Map<String, dynamic> json) {
    return ParentUserInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}

class ParentReportDetail {
  final String id;
  final String childName;
  final String fatherName;
  final String? placeLost;
  final String gender;
  final String lostTime;
  final String? additionalDetails;
  final String contactNumber;
  final String emergency;
  final String status;
  final double latitude;
  final double longitude;
  final String createdAt;
  final List<DetailedReportImage> images;
  final ParentUserInfo parent;
  final List<MatchInfo> matchesAsParent;

  ParentReportDetail({
    required this.id,
    required this.childName,
    required this.fatherName,
    this.placeLost,
    required this.gender,
    required this.lostTime,
    this.additionalDetails,
    required this.contactNumber,
    required this.emergency,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.images,
    required this.parent,
    required this.matchesAsParent,
  });

  factory ParentReportDetail.fromJson(Map<String, dynamic> json) {
    return ParentReportDetail(
      id: json['id'] ?? '',
      childName: json['childName'] ?? 'Unknown',
      fatherName: json['fatherName'] ?? 'Unknown',
      placeLost: json['placeLost'],
      gender: json['gender'] ?? 'OTHER',
      lostTime: json['lostTime'] ?? '',
      additionalDetails: json['additionalDetails'],
      contactNumber: json['contactNumber'] ?? '',
      emergency: json['emergency'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      createdAt: json['createdAt'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((item) => DetailedReportImage.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      parent: json['parent'] != null
          ? ParentUserInfo.fromJson(json['parent'])
          : ParentUserInfo(id: '', name: 'Unknown', phone: '', email: ''),
      matchesAsParent: (json['matchesAsParent'] as List<dynamic>?)
              ?.map((item) => MatchInfo.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childName': childName,
      'fatherName': fatherName,
      'placeLost': placeLost,
      'gender': gender,
      'lostTime': lostTime,
      'additionalDetails': additionalDetails,
      'contactNumber': contactNumber,
      'emergency': emergency,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt,
      'images': images.map((i) => i.toJson()).toList(),
      'parent': parent.toJson(),
      'matchesAsParent': matchesAsParent.map((m) => m.toJson()).toList(),
    };
  }
}

class ParentReportDetailData {
  final ParentReportDetail report;

  ParentReportDetailData({required this.report});

  factory ParentReportDetailData.fromJson(Map<String, dynamic> json) {
    return ParentReportDetailData(
      report: ParentReportDetail.fromJson(json['report']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report': report.toJson(),
    };
  }
}

class ParentReportByIdResponse {
  final bool success;
  final String? message;
  final ParentReportDetailData? data;

  ParentReportByIdResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory ParentReportByIdResponse.fromJson(Map<String, dynamic> json) {
    return ParentReportByIdResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? ParentReportDetailData.fromJson(json['data']) : null,
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
