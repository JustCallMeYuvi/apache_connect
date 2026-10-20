// import 'package:equatable/equatable.dart';

// /// Pure domain entity representing an authenticated user
// class User extends Equatable {
//   final String id;
//   final String username;
//   final String email;
//   final String? displayName;
//   final String? token;

//   const User({
//     required this.id,
//     required this.username,
//     required this.email,
//     this.displayName,
//     this.token,
//   });

//   @override
//   List<Object?> get props => [id, username, email, displayName, token];
// }

import 'package:equatable/equatable.dart';

/// Pure domain entity representing an authenticated user with enterprise profile attributes
class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? displayName;
  final String? token;
  final String? phone;
  final String? barcode;
  final String? department;
  final String? factory;
  final String? designation;
  final String? role;
  final String? status;
  final DateTime? signedInAt;
  final DateTime? expiresAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.displayName,
    this.token,
    this.phone,
    this.barcode,
    this.department,
    this.factory,
    this.designation,
    this.role,
    this.status,
    this.signedInAt,
    this.expiresAt,
  });

  String get safeDisplayName =>
      (displayName != null && displayName!.isNotEmpty) ? displayName! : 'Syed Imran';
  String get safeEmail => (email.isNotEmpty) ? email : 'imran@apache.co';
  String get safePhone => phone ?? '+91 90000 01000';
  String get safeBarcode => barcode ?? 'APC1001';
  String get safeDepartment => department ?? 'IT';
  String get safeFactory => factory ?? 'APC';
  String get safeDesignation => designation ?? 'System Admin';
  String get safeRole => role ?? 'Admin';
  String get safeStatus => status ?? 'Active';
  String get safeToken => token != null && token!.isNotEmpty ? token! : '58v0xkgw••••••';

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? displayName,
    String? token,
    String? phone,
    String? barcode,
    String? department,
    String? factory,
    String? designation,
    String? role,
    String? status,
    DateTime? signedInAt,
    DateTime? expiresAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      barcode: barcode ?? this.barcode,
      department: department ?? this.department,
      factory: factory ?? this.factory,
      designation: designation ?? this.designation,
      role: role ?? this.role,
      status: status ?? this.status,
      signedInAt: signedInAt ?? this.signedInAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        displayName,
        token,
        phone,
        barcode,
        department,
        factory,
        designation,
        role,
        status,
        signedInAt,
        expiresAt,
      ];
}
