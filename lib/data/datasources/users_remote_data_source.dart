import '../../core/network/api_result.dart';
import '../../domain/entities/managed_user.dart';
import '../models/managed_user_model.dart';

abstract class UsersRemoteDataSource {
  Future<ApiResult<List<ManagedUserModel>>> getUsers();
  Future<ApiResult<List<String>>> getFactories();
  Future<ApiResult<List<EmployeeLookup>>> getEmployeesByFactory(String factory);
  Future<ApiResult<ManagedUserModel>> createUser(ManagedUser user);
  Future<ApiResult<ManagedUserModel>> updateUser(ManagedUser user);
  Future<ApiResult<ManagedUserModel>> toggleUserStatus(String barcode, bool newStatus);
  Future<ApiResult<bool>> deleteUser(String barcode);
}

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  // Initial 7 records matching Screenshots 1, 2, 3, 4, 5
  final List<ManagedUserModel> _users = [
    const ManagedUserModel(
      barcode: 'APC1001',
      name: 'Syed Imran',
      username: 'Imran@67657',
      email: 'imran@apache.co',
      phone: '+91 90000 01000',
      role: 'Admin',
      factory: '100 · APC',
      department: 'IT',
      designation: 'System Admin',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
    const ManagedUserModel(
      barcode: 'APC1002',
      name: 'Ravi Kumar',
      username: 'Ravi@1001',
      email: 'ravi@apache.co',
      phone: '+91 90000 02000',
      role: 'Manager',
      factory: '100 · APC',
      department: 'Finance',
      designation: 'Manager',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
    const ManagedUserModel(
      barcode: 'MXK2001',
      name: 'Anita Sharma',
      username: 'Anita@1002',
      email: 'anita@apache.co',
      phone: '+91 90000 03000',
      role: 'Employee',
      factory: '200 · Maxking',
      department: 'HR',
      designation: 'Executive',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
    const ManagedUserModel(
      barcode: 'APC1003',
      name: 'Meena Rao',
      username: 'Meena@1003',
      email: 'meena@apache.co',
      phone: '+91 90000 04000',
      role: 'Employee',
      factory: '100 · APC',
      department: 'Finance',
      designation: 'Executive',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
    const ManagedUserModel(
      barcode: 'MXK2002',
      name: 'Priya Nair',
      username: 'Priya@1004',
      email: 'priya@apache.co',
      phone: '+91 90000 05000',
      role: 'Employee',
      factory: '200 · Maxking',
      department: 'Operations',
      designation: 'Executive',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
    const ManagedUserModel(
      barcode: 'APC1004',
      name: 'Suresh Babu',
      username: 'Suresh@1005',
      email: 'suresh@apache.co',
      phone: '+91 90000 06000',
      role: 'Employee',
      factory: '100 · APC',
      department: 'Logistics',
      designation: 'Supervisor',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
    const ManagedUserModel(
      barcode: 'MXK2003',
      name: 'Kavya Reddy',
      username: 'Kavya@1006',
      email: 'kavya@apache.co',
      phone: '+91 90000 07000',
      role: 'Employee',
      factory: '200 · Maxking',
      department: 'Quality',
      designation: 'Inspector',
      locationStatus: 'Anywhere',
      location: '—',
      isActive: true,
    ),
  ];

  // Available factories for creation dropdown
  final List<String> _factories = [
    '100 · APC',
    '200 · Maxking',
    '300 · Chennai Unit',
  ];

  // Employee catalogue for autofill
  final Map<String, List<EmployeeLookup>> _employeeCatalogue = {
    '100 · APC': [
      const EmployeeLookup(
        barcode: 'APC1005',
        name: 'Vikram Singh',
        department: 'IT',
        designation: 'Network Architect',
        factory: '100 · APC',
        defaultEmail: 'vikram.singh@apache.co',
        defaultPhone: '+91 90000 08000',
      ),
      const EmployeeLookup(
        barcode: 'APC1006',
        name: 'Divya Menon',
        department: 'Finance',
        designation: 'Lead Accountant',
        factory: '100 · APC',
        defaultEmail: 'divya.menon@apache.co',
        defaultPhone: '+91 90000 09000',
      ),
      const EmployeeLookup(
        barcode: 'APC1007',
        name: 'Arun Patel',
        department: 'Logistics',
        designation: 'Warehouse Manager',
        factory: '100 · APC',
        defaultEmail: 'arun.patel@apache.co',
        defaultPhone: '+91 90000 10000',
      ),
    ],
    '200 · Maxking': [
      const EmployeeLookup(
        barcode: 'MXK2004',
        name: 'Sunil Verma',
        department: 'Quality',
        designation: 'QA Lead',
        factory: '200 · Maxking',
        defaultEmail: 'sunil.verma@apache.co',
        defaultPhone: '+91 90000 11000',
      ),
      const EmployeeLookup(
        barcode: 'MXK2005',
        name: 'Deepa Shah',
        department: 'HR',
        designation: 'Senior Recruiter',
        factory: '200 · Maxking',
        defaultEmail: 'deepa.shah@apache.co',
        defaultPhone: '+91 90000 12000',
      ),
    ],
    '300 · Chennai Unit': [
      const EmployeeLookup(
        barcode: 'CHN3001',
        name: 'Karthik Raja',
        department: 'Operations',
        designation: 'Plant Supervisor',
        factory: '300 · Chennai Unit',
        defaultEmail: 'karthik.raja@apache.co',
        defaultPhone: '+91 90000 13000',
      ),
      const EmployeeLookup(
        barcode: 'CHN3002',
        name: 'Pooja Sundaram',
        department: 'Safety',
        designation: 'Safety Compliance Officer',
        factory: '300 · Chennai Unit',
        defaultEmail: 'pooja.s@apache.co',
        defaultPhone: '+91 90000 14000',
      ),
    ],
  };

  @override
  Future<ApiResult<List<ManagedUserModel>>> getUsers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 250));
    return ApiResult.success(List.from(_users));
  }

  @override
  Future<ApiResult<List<String>>> getFactories() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return ApiResult.success(List.from(_factories));
  }

  @override
  Future<ApiResult<List<EmployeeLookup>>> getEmployeesByFactory(String factory) async {
    await Future.delayed(const Duration(milliseconds: 180));
    final list = _employeeCatalogue[factory] ?? [];
    return ApiResult.success(list);
  }

  @override
  Future<ApiResult<ManagedUserModel>> createUser(ManagedUser user) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final model = ManagedUserModel.fromEntity(user);
    // Insert at beginning of list
    _users.insert(0, model);
    return ApiResult.success(model);
  }

  @override
  Future<ApiResult<ManagedUserModel>> updateUser(ManagedUser user) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final index = _users.indexWhere((u) => u.barcode == user.barcode);
    if (index != -1) {
      final model = ManagedUserModel.fromEntity(user);
      _users[index] = model;
      return ApiResult.success(model);
    }
    return ApiResult.failure('User with barcode ${user.barcode} not found');
  }

  @override
  Future<ApiResult<ManagedUserModel>> toggleUserStatus(String barcode, bool newStatus) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _users.indexWhere((u) => u.barcode == barcode);
    if (index != -1) {
      final updated = _users[index].copyWith(isActive: newStatus);
      final model = ManagedUserModel.fromEntity(updated);
      _users[index] = model;
      return ApiResult.success(model);
    }
    return ApiResult.failure('User with barcode $barcode not found');
  }

  @override
  Future<ApiResult<bool>> deleteUser(String barcode) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _users.indexWhere((u) => u.barcode == barcode);
    if (index != -1) {
      _users.removeAt(index);
      return  ApiResult.success(true);
    }
    return ApiResult.failure('User with barcode $barcode not found');
  }
}
