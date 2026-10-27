import 'dart:math';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/managed_user.dart';

enum UsersStatus { initial, loading, success, failure }

class UsersState extends Equatable {
  final UsersStatus status;
  final List<ManagedUser> allUsers;
  final List<ManagedUser> filteredUsers;
  final String searchQuery;
  final int currentPage;
  final int pageSize;
  final List<String> factories;
  final List<EmployeeLookup> availableEmployees;
  final String? selectedFactory;
  final EmployeeLookup? selectedEmployee;
  final bool isSaving;
  final bool isDeleting;
  final String? actionMessage;
  final String? errorMessage;

  const UsersState({
    this.status = UsersStatus.initial,
    this.allUsers = const [],
    this.filteredUsers = const [],
    this.searchQuery = '',
    this.currentPage = 1,
    this.pageSize = 10,
    this.factories = const [],
    this.availableEmployees = const [],
    this.selectedFactory,
    this.selectedEmployee,
    this.isSaving = false,
    this.isDeleting = false,
    this.actionMessage,
    this.errorMessage,
  });

  int get totalRecords => filteredUsers.length;

  int get totalPages => max(1, (totalRecords / pageSize).ceil());

  List<ManagedUser> get paginatedUsers {
    if (filteredUsers.isEmpty) return [];
    final startIndex = (currentPage - 1) * pageSize;
    if (startIndex >= filteredUsers.length) return [];
    final endIndex = min(startIndex + pageSize, filteredUsers.length);
    return filteredUsers.sublist(startIndex, endIndex);
  }

  int get startIndexDisplay => totalRecords == 0 ? 0 : (currentPage - 1) * pageSize + 1;

  int get endIndexDisplay => min(currentPage * pageSize, totalRecords);

  UsersState copyWith({
    UsersStatus? status,
    List<ManagedUser>? allUsers,
    List<ManagedUser>? filteredUsers,
    String? searchQuery,
    int? currentPage,
    int? pageSize,
    List<String>? factories,
    List<EmployeeLookup>? availableEmployees,
    String? selectedFactory,
    bool clearSelectedFactory = false,
    EmployeeLookup? selectedEmployee,
    bool clearSelectedEmployee = false,
    bool? isSaving,
    bool? isDeleting,
    String? actionMessage,
    bool clearActionMessage = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return UsersState(
      status: status ?? this.status,
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      factories: factories ?? this.factories,
      availableEmployees: availableEmployees ?? this.availableEmployees,
      selectedFactory: clearSelectedFactory ? null : (selectedFactory ?? this.selectedFactory),
      selectedEmployee: clearSelectedEmployee ? null : (selectedEmployee ?? this.selectedEmployee),
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      actionMessage: clearActionMessage ? null : (actionMessage ?? this.actionMessage),
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        allUsers,
        filteredUsers,
        searchQuery,
        currentPage,
        pageSize,
        factories,
        availableEmployees,
        selectedFactory,
        selectedEmployee,
        isSaving,
        isDeleting,
        actionMessage,
        errorMessage,
      ];
}
