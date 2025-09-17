class DashboardStats {
  final int totalReports;
  final int activeReports;
  final int resolvedReports;
  final int totalMatches;
  final int confirmedMatches;
  final int pendingMatches;
  final int totalUsers;
  final int activeUsers;
  final double successRate;
  final List<RecentActivity> recentActivities;

  DashboardStats({
    required this.totalReports,
    required this.activeReports,
    required this.resolvedReports,
    required this.totalMatches,
    required this.confirmedMatches,
    required this.pendingMatches,
    required this.totalUsers,
    required this.activeUsers,
    required this.successRate,
    required this.recentActivities,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalReports: json['totalReports'] ?? 0,
      activeReports: json['activeReports'] ?? 0,
      resolvedReports: json['resolvedReports'] ?? 0,
      totalMatches: json['totalMatches'] ?? 0,
      confirmedMatches: json['confirmedMatches'] ?? 0,
      pendingMatches: json['pendingMatches'] ?? 0,
      totalUsers: json['totalUsers'] ?? 0,
      activeUsers: json['activeUsers'] ?? 0,
      successRate: (json['successRate'] ?? 0).toDouble(),
      recentActivities: (json['recentActivities'] as List<dynamic>? ?? [])
          .map((activity) => RecentActivity.fromJson(activity))
          .toList(),
    );
  }
}

class RecentActivity {
  final String id;
  final String type;
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  RecentActivity({
    required this.id,
    required this.type,
    required this.message,
    required this.timestamp,
    this.metadata,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      metadata: json['metadata'],
    );
  }
}