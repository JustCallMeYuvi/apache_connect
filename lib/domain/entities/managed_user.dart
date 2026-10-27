import 'package:equatable/equatable.dart';

/// Clean Architecture Entity representing an administrative user in ApacheConnect.
class ManagedUser extends Equatable {
  final String barcode;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String role;
  final String factory;
  final String department;
  final String designation;
  final String locationStatus;
  final String location;
  final bool isActive;

  const ManagedUser({
    required this.barcode,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.role,
    required this.factory,
    required this.department,
    required this.designation,
    this.locationStatus = 'Anywhere',
    this.location = '—',
    this.isActive = true,
  });

  ManagedUser copyWith({
    String? barcode,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? role,
    String? factory,
    String? department,
    String? designation,
    String? locationStatus,
    String? location,
    bool? isActive,
  }) {
    return ManagedUser(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      factory: factory ?? this.factory,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      locationStatus: locationStatus ?? this.locationStatus,
      location: location ?? this.location,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        barcode,
        name,
        username,
        email,
        phone,
        role,
        factory,
        department,
        designation,
        locationStatus,
        location,
        isActive,
      ];
}

/// Lookup entity for employee data autofill from barcode
class EmployeeLookup extends Equatable {
  final String barcode;
  final String name;
  final String department;
  final String designation;
  final String factory;
  final String defaultEmail;
  final String defaultPhone;

  const EmployeeLookup({
    required this.barcode,
    required this.name,
    required this.department,
    required this.designation,
    required this.factory,
    this.defaultEmail = '',
    this.defaultPhone = '',
  });

  @override
  List<Object?> get props => [
        barcode,
        name,
        department,
        designation,
        factory,
        defaultEmail,
        defaultPhone,
      ];
}
