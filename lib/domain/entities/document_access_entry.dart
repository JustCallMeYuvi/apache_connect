import 'package:equatable/equatable.dart';

enum AccessEntryType {
  role,
  employee,
}

/// Entity representing a selectable Role or Employee for document access control
class DocumentAccessEntry extends Equatable {
  final String id;
  final String name;
  final String detail;
  final AccessEntryType type;
  final int? employeeCount;
  final String? department;
  final String? emailOrId;
  final String? designation;

  const DocumentAccessEntry({
    required this.id,
    required this.name,
    required this.detail,
    required this.type,
    this.employeeCount,
    this.department,
    this.emailOrId,
    this.designation,
  });

  bool get isRole => type == AccessEntryType.role;
  bool get isEmployee => type == AccessEntryType.employee;

  /// Formatted subtitle shown in the access list (e.g. "Ravi@1001 · Finance · Manager" or "1 employees")
  String get displaySubtitle {
    if (isRole) {
      return '$name · ${employeeCount ?? 0} employees';
    }
    return '$name · $detail';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        detail,
        type,
        employeeCount,
        department,
        emailOrId,
        designation,
      ];
}
