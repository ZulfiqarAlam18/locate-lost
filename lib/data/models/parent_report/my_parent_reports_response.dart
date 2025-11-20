// Response model for GET /api/reports/parent/my endpoint

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

// Supporting classes first
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
    print('📷 Parsing ReportImage from JSON: $json');
    String rawImageUrl = json['imageUrl'] ?? '';
    String imageUrl = _fixImageUrl(rawImageUrl);
    print('📷 Final imageUrl: $imageUrl');
    
    return ReportImage(
      id: json['id'] ?? '',
      imageUrl: imageUrl,
      fileName: json['fileName'],
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

class ParentInfo {
  final String id;
  final String name;
  final String phone;

  ParentInfo({
    required this.id,
    required this.name,
    required this.phone,
  });

  factory ParentInfo.fromJson(Map<String, dynamic> json) {
    return ParentInfo(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }
}

class MatchCount {
  final int matchesAsParent;

  MatchCount({required this.matchesAsParent});

  factory MatchCount.fromJson(Map<String, dynamic> json) {
    return MatchCount(
      matchesAsParent: json['matchesAsParent'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matchesAsParent': matchesAsParent,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'pages': pages,
    };
  }
}

class ParentReportItem {
  final String id;
  final String childName;
  final String fatherName;
  final String gender;
  final String? placeLost;
  final String lostTime;
  final String status;
  final String createdAt;
  final List<ReportImage> images;
  final ParentInfo parent;
  final MatchCount matchCount;

  ParentReportItem({
    required this.id,
    required this.childName,
    required this.fatherName,
    required this.gender,
    this.placeLost,
    required this.lostTime,
    required this.status,
    required this.createdAt,
    required this.images,
    required this.parent,
    required this.matchCount,
  });

  factory ParentReportItem.fromJson(Map<String, dynamic> json) {
    return ParentReportItem(
      id: json['id'] ?? '',
      childName: json['childName'] ?? 'Unknown',
      fatherName: json['fatherName'] ?? 'Unknown',
      gender: json['gender'] ?? 'OTHER',
      placeLost: json['placeLost'],
      lostTime: json['lostTime'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      createdAt: json['createdAt'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((item) => ReportImage.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      parent: json['parent'] != null
          ? ParentInfo.fromJson(json['parent'])
          : ParentInfo(id: '', name: 'Unknown', phone: ''),
      matchCount: json['_count'] != null
          ? MatchCount.fromJson(json['_count'])
          : MatchCount(matchesAsParent: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'childName': childName,
      'fatherName': fatherName,
      'gender': gender,
      'placeLost': placeLost,
      'lostTime': lostTime,
      'status': status,
      'createdAt': createdAt,
      'images': images.map((i) => i.toJson()).toList(),
      'parent': parent.toJson(),
      '_count': matchCount.toJson(),
    };
  }
}

class MyParentReportsData {
  final List<ParentReportItem> reports;
  final PaginationInfo pagination;

  MyParentReportsData({
    required this.reports,
    required this.pagination,
  });

  factory MyParentReportsData.fromJson(Map<String, dynamic> json) {
    return MyParentReportsData(
      reports: (json['reports'] as List<dynamic>?)
              ?.map((item) => ParentReportItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      pagination: json['pagination'] != null
          ? PaginationInfo.fromJson(json['pagination'])
          : PaginationInfo(page: 1, limit: 10, total: 0, pages: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reports': reports.map((r) => r.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class MyParentReportsResponse {
  final bool success;
  final String? message;
  final MyParentReportsData? data;

  MyParentReportsResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory MyParentReportsResponse.fromJson(Map<String, dynamic> json) {
    return MyParentReportsResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? MyParentReportsData.fromJson(json['data']) : null,
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
