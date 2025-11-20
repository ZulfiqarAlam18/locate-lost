import 'package:locate_lost/utils/constants/endpoints.dart';

// Helper function to fix localhost URLs
String _fixImageUrl(String url) {
  if (url.startsWith('http://localhost:5000/')) {
    final fixedUrl = url.replaceFirst('http://localhost:5000/', Base_URL);
    print('🔧 Fixed localhost URL: $url -> $fixedUrl');
    return fixedUrl;
  }
  // Handle relative URLs (remove leading slash to avoid double slash)
  if (!url.startsWith('http')) {
    final cleanUrl = url.startsWith('/') ? url.substring(1) : url;
    final fixedUrl = Base_URL + cleanUrl;
    print('🔧 Fixed relative URL: $url -> $fixedUrl');
    return fixedUrl;
  }
  return url;
}

class MyFinderReportsResponse {
  final bool success;
  final MyFinderReportsData data;

  MyFinderReportsResponse({
    required this.success,
    required this.data,
  });

  factory MyFinderReportsResponse.fromJson(Map<String, dynamic> json) {
    return MyFinderReportsResponse(
      success: json['success'] ?? false,
      data: MyFinderReportsData.fromJson(json['data'] ?? {}),
    );
  }
}

class MyFinderReportsData {
  final List<FinderReportItem> reports;
  final PaginationInfo pagination;

  MyFinderReportsData({
    required this.reports,
    required this.pagination,
  });

  factory MyFinderReportsData.fromJson(Map<String, dynamic> json) {
    return MyFinderReportsData(
      reports: (json['reports'] as List<dynamic>?)
              ?.map((e) => FinderReportItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination: PaginationInfo.fromJson(json['pagination'] ?? {}),
    );
  }
}

class FinderReportItem {
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
  final List<ReportImage> images;
  final FinderInfo finder;
  final MatchCount count;

  FinderReportItem({
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
    required this.count,
  });

  factory FinderReportItem.fromJson(Map<String, dynamic> json) {
    return FinderReportItem(
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
              ?.map((e) => ReportImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      finder: FinderInfo.fromJson(json['finder'] ?? {}),
      count: MatchCount.fromJson(json['_count'] ?? {}),
    );
  }
}

class ReportImage {
  final String id;
  final String imageUrl;
  final String? fileName;

  ReportImage({
    required this.id,
    required this.imageUrl,
    this.fileName,
  });

  factory ReportImage.fromJson(Map<String, dynamic> json) {
    final originalUrl = json['imageUrl'] ?? '';
    final fixedUrl = _fixImageUrl(originalUrl);

    return ReportImage(
      id: json['id'] ?? '',
      imageUrl: fixedUrl,
      fileName: json['fileName'],
    );
  }
}

class FinderInfo {
  final String id;
  final String name;
  final String? phone;
  final String? email;

  FinderInfo({
    required this.id,
    required this.name,
    this.phone,
    this.email,
  });

  factory FinderInfo.fromJson(Map<String, dynamic> json) {
    return FinderInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class MatchCount {
  final int matchesAsFinder;

  MatchCount({
    required this.matchesAsFinder,
  });

  factory MatchCount.fromJson(Map<String, dynamic> json) {
    return MatchCount(
      matchesAsFinder: json['matchesAsFinder'] ?? 0,
    );
  }
}

class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int pages;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 0,
    );
  }
}
