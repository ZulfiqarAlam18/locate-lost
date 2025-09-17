class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final bool isActive;
  final String? profileImage;
  final String? cnic;
  final String? address;
  final DateTime? lastLogin;
  final DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.isActive,
    this.profileImage,
    this.cnic,
    this.address,
    this.lastLogin,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('🔍 Creating User from JSON: $json');
    
    return User(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? json['phoneNumber'] ?? '').toString(),
      role: (json['role'] ?? 'PARENT').toString(),
      isVerified: json['isVerified'] == true || json['verified'] == true,
      isActive: json['isActive'] != false && json['active'] != false,
      profileImage: json['profileImage']?.toString(),
      cnic: json['cnic']?.toString(),
      address: json['address']?.toString(),
      lastLogin: json['lastLogin'] != null ? DateTime.tryParse(json['lastLogin'].toString()) : null,
      createdAt: DateTime.tryParse((json['createdAt'] ?? json['created_at'] ?? DateTime.now().toIso8601String()).toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      'isActive': isActive,
      'profileImage': profileImage,
      'cnic': cnic,
      'address': address,
      'lastLogin': lastLogin?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}