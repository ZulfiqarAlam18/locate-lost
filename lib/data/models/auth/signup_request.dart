class SignupRequest {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role;

  SignupRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.role = 'PARENT', // Default role
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
    };
  }

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'PARENT',
    );
  }
}
