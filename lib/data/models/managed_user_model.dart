import '../../domain/entities/managed_user.dart';

class ManagedUserModel extends ManagedUser {
  const ManagedUserModel({
    required super.barcode,
    required super.name,
    required super.username,
    required super.email,
    required super.phone,
    required super.role,
    required super.factory,
    required super.department,
    required super.designation,
    super.locationStatus = 'Anywhere',
    super.location = '—',
    super.isActive = true,
  });

  factory ManagedUserModel.fromJson(Map<String, dynamic> json) {
    return ManagedUserModel(
      barcode: json['barcode'] as String? ?? '',
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String? ?? 'Employee',
      factory: json['factory'] as String? ?? '',
      department: json['department'] as String? ?? '',
      designation: json['designation'] as String? ?? '',
      locationStatus: json['locationStatus'] as String? ?? 'Anywhere',
      location: json['location'] as String? ?? '—',
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'role': role,
      'factory': factory,
      'department': department,
      'designation': designation,
      'locationStatus': locationStatus,
      'location': location,
      'isActive': isActive,
    };
  }

  factory ManagedUserModel.fromEntity(ManagedUser entity) {
    return ManagedUserModel(
      barcode: entity.barcode,
      name: entity.name,
      username: entity.username,
      email: entity.email,
      phone: entity.phone,
      role: entity.role,
      factory: entity.factory,
      department: entity.department,
      designation: entity.designation,
      locationStatus: entity.locationStatus,
      location: entity.location,
      isActive: entity.isActive,
    );
  }
}
