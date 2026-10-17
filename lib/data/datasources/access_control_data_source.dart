import '../../domain/entities/document_access_entry.dart';

abstract class AccessControlDataSource {
  Future<List<DocumentAccessEntry>> getAvailableRoles();
  Future<List<DocumentAccessEntry>> getAvailableEmployees();
  Future<List<DocumentAccessEntry>> getAllAccessEntries();
}

class AccessControlDataSourceImpl implements AccessControlDataSource {
  static const List<DocumentAccessEntry> _roles = [
    DocumentAccessEntry(
      id: 'role_admin',
      name: 'Admin',
      detail: '1 employees',
      type: AccessEntryType.role,
      employeeCount: 1,
    ),
    DocumentAccessEntry(
      id: 'role_manager',
      name: 'Manager',
      detail: '1 employees',
      type: AccessEntryType.role,
      employeeCount: 1,
    ),
    DocumentAccessEntry(
      id: 'role_staff',
      name: 'Staff',
      detail: '0 employees',
      type: AccessEntryType.role,
      employeeCount: 0,
    ),
  ];

  static const List<DocumentAccessEntry> _employees = [
    DocumentAccessEntry(
      id: 'emp_ravi',
      name: 'Ravi Kumar',
      detail: 'Ravi@1001 · Finance · Manager',
      type: AccessEntryType.employee,
      department: 'Finance',
      emailOrId: 'Ravi@1001',
      designation: 'Manager',
    ),
    DocumentAccessEntry(
      id: 'emp_anita',
      name: 'Anita Sharma',
      detail: 'Anita@1002 · HR · Employee',
      type: AccessEntryType.employee,
      department: 'HR',
      emailOrId: 'Anita@1002',
      designation: 'Employee',
    ),
    DocumentAccessEntry(
      id: 'emp_meena',
      name: 'Meena Rao',
      detail: 'Meena@1003 · Finance · Employee',
      type: AccessEntryType.employee,
      department: 'Finance',
      emailOrId: 'Meena@1003',
      designation: 'Employee',
    ),
    DocumentAccessEntry(
      id: 'emp_priya',
      name: 'Priya Nair',
      detail: 'Priya@1004 · Operations · Employee',
      type: AccessEntryType.employee,
      department: 'Operations',
      emailOrId: 'Priya@1004',
      designation: 'Employee',
    ),
  ];

  @override
  Future<List<DocumentAccessEntry>> getAvailableRoles() async {
    return _roles;
  }

  @override
  Future<List<DocumentAccessEntry>> getAvailableEmployees() async {
    return _employees;
  }

  @override
  Future<List<DocumentAccessEntry>> getAllAccessEntries() async {
    return [..._roles, ..._employees];
  }
}
