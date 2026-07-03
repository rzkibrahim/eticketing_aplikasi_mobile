class UserModel {
  final String id;
  final String name;
  final String email;
  final String username;
  final String password;
  final String role; // 'user', 'helpdesk', 'admin'
  final String department;
  final String avatar;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.role,
    required this.department,
    required this.avatar,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'user',
      department: json['department'] ?? '',
      avatar: json['avatar'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'role': role,
      'department': department,
      'avatar': avatar,
      'phone': phone,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? department,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username,
      password: password,
      role: role,
      department: department ?? this.department,
      avatar: avatar,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'role': role,
      'department': department,
      'avatar': avatar,
      'phone': phone,
    };
  }
}
