// import '../../domain/entities/user.dart';

// /// Data transfer model for User with JSON serialization
// class UserModel extends User {
//   const UserModel({
//     required super.id,
//     required super.username,
//     required super.email,
//     super.displayName,
//     super.token,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as String? ?? 'usr_${DateTime.now().millisecondsSinceEpoch}',
//       username: json['username'] as String? ?? '',
//       email: json['email'] as String? ?? '',
//       displayName: json['display_name'] as String?,
//       token: json['token'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'username': username,
//       'email': email,
//       'display_name': displayName,
//       'token': token,
//     };
//   }
// }

import '../../domain/entities/user.dart';

/// Data transfer model for User with JSON serialization
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    super.displayName,
    super.token,
    super.phone,
    super.barcode,
    super.department,
    super.factory,
    super.designation,
    super.role,
    super.status,
    super.signedInAt,
    super.expiresAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? 'usr_${DateTime.now().millisecondsSinceEpoch}',
      username: json['username'] as String? ?? 'imran@apache.co',
      email: json['email'] as String? ?? 'imran@apache.co',
      displayName: json['display_name'] as String? ?? json['empName'] as String? ?? 'Syed Imran',
      token: json['token'] as String? ?? '58v0xkgw••••••',
      phone: json['phone'] as String? ?? '+91 90000 01000',
      barcode: json['barcode'] as String? ?? 'APC1001',
      department: json['deptName'] as String? ?? json['department'] as String? ?? 'IT',
      factory: json['factory'] as String? ?? 'APC',
      designation: json['designation'] as String? ?? 'System Admin',
      role: json['roleName'] as String? ?? json['role'] as String? ?? 'Admin',
      status: json['status'] as String? ?? 'Active',
      signedInAt: json['signedInAt'] != null
          ? DateTime.tryParse(json['signedInAt'].toString())
          : DateTime(2026, 10, 17, 15, 9),
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'].toString())
          : DateTime(2026, 11, 16, 15, 9),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'display_name': displayName,
      'token': token,
      'phone': phone,
      'barcode': barcode,
      'department': department,
      'factory': factory,
      'designation': designation,
      'role': role,
      'status': status,
      'signedInAt': signedInAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }
}
