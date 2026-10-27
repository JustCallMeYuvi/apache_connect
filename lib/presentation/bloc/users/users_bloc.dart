import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/managed_user.dart';
import '../../../domain/usecases/manage_user_usecases.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final ToggleUserStatusUseCase toggleUserStatusUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final GetFactoriesUseCase getFactoriesUseCase;
  final GetEmployeesByFactoryUseCase getEmployeesByFactoryUseCase;

  UsersBloc({
    required this.getUsersUseCase,
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.toggleUserStatusUseCase,
    required this.deleteUserUseCase,
    required this.getFactoriesUseCase,
    required this.getEmployeesByFactoryUseCase,
  }) : super(const UsersState()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<SearchUsersEvent>(_onSearchUsers);
    on<ChangePageEvent>(_onChangePage);
    on<LoadFactoriesEvent>(_onLoadFactories);
    on<SelectFactoryForNewUserEvent>(_onSelectFactory);
    on<SelectEmployeeForNewUserEvent>(_onSelectEmployee);
    on<ResetNewUserFormEvent>(_onResetNewUserForm);
    on<CreateUserEvent>(_onCreateUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<ToggleUserStatusEvent>(_onToggleUserStatus);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(status: UsersStatus.loading, clearErrorMessage: true));
    final result = await getUsersUseCase();
    result.when(
      success: (users) {
        emit(state.copyWith(
          status: UsersStatus.success,
          allUsers: users,
          filteredUsers: _filter(users, state.searchQuery),
          currentPage: 1,
        ));
      },
      failure: (msg) {
        emit(state.copyWith(
          status: UsersStatus.failure,
          errorMessage: msg,
        ));
      },
    );
  }

  void _onSearchUsers(
    SearchUsersEvent event,
    Emitter<UsersState> emit,
  ) {
    final query = event.query;
    final filtered = _filter(state.allUsers, query);
    emit(state.copyWith(
      searchQuery: query,
      filteredUsers: filtered,
      currentPage: 1,
    ));
  }

  void _onChangePage(
    ChangePageEvent event,
    Emitter<UsersState> emit,
  ) {
    if (event.page >= 1 && event.page <= state.totalPages) {
      emit(state.copyWith(currentPage: event.page));
    }
  }

  Future<void> _onLoadFactories(
    LoadFactoriesEvent event,
    Emitter<UsersState> emit,
  ) async {
    final result = await getFactoriesUseCase();
    result.when(
      success: (factories) {
        emit(state.copyWith(factories: factories));
      },
      failure: (_) {},
    );
  }

  Future<void> _onSelectFactory(
    SelectFactoryForNewUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(
      selectedFactory: event.factory,
      clearSelectedEmployee: true,
      availableEmployees: [],
    ));

    final result = await getEmployeesByFactoryUseCase(event.factory);
    result.when(
      success: (employees) {
        emit(state.copyWith(availableEmployees: employees));
      },
      failure: (_) {},
    );
  }

  void _onSelectEmployee(
    SelectEmployeeForNewUserEvent event,
    Emitter<UsersState> emit,
  ) {
    emit(state.copyWith(selectedEmployee: event.employee));
  }

  void _onResetNewUserForm(
    ResetNewUserFormEvent event,
    Emitter<UsersState> emit,
  ) {
    emit(state.copyWith(
      clearSelectedFactory: true,
      clearSelectedEmployee: true,
      availableEmployees: [],
    ));
  }

  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, clearErrorMessage: true, clearActionMessage: true));
    final result = await createUserUseCase(event.user);
    result.when(
      success: (createdUser) {
        final updatedList = [createdUser, ...state.allUsers];
        emit(state.copyWith(
          isSaving: false,
          allUsers: updatedList,
          filteredUsers: _filter(updatedList, state.searchQuery),
          actionMessage: 'User ${createdUser.name} created successfully',
          clearSelectedFactory: true,
          clearSelectedEmployee: true,
          availableEmployees: [],
        ));
      },
      failure: (msg) {
        emit(state.copyWith(
          isSaving: false,
          errorMessage: msg,
        ));
      },
    );
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, clearErrorMessage: true, clearActionMessage: true));
    final result = await updateUserUseCase(event.user);
    result.when(
      success: (updatedUser) {
        final updatedList = state.allUsers.map((u) {
          return u.barcode == updatedUser.barcode ? updatedUser : u;
        }).toList();
        emit(state.copyWith(
          isSaving: false,
          allUsers: updatedList,
          filteredUsers: _filter(updatedList, state.searchQuery),
          actionMessage: 'User ${updatedUser.name} updated successfully',
        ));
      },
      failure: (msg) {
        emit(state.copyWith(
          isSaving: false,
          errorMessage: msg,
        ));
      },
    );
  }

  Future<void> _onToggleUserStatus(
    ToggleUserStatusEvent event,
    Emitter<UsersState> emit,
  ) async {
    final newStatus = !event.currentStatus;
    final result = await toggleUserStatusUseCase(event.barcode, newStatus);
    result.when(
      success: (updatedUser) {
        final updatedList = state.allUsers.map((u) {
          return u.barcode == updatedUser.barcode ? updatedUser : u;
        }).toList();
        emit(state.copyWith(
          allUsers: updatedList,
          filteredUsers: _filter(updatedList, state.searchQuery),
          actionMessage: 'User ${updatedUser.name} ${newStatus ? 'activated' : 'deactivated'} successfully',
        ));
      },
      failure: (msg) {
        emit(state.copyWith(errorMessage: msg));
      },
    );
  }

  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(state.copyWith(isDeleting: true, clearErrorMessage: true, clearActionMessage: true));
    final result = await deleteUserUseCase(event.barcode);
    result.when(
      success: (_) {
        final updatedList = state.allUsers.where((u) => u.barcode != event.barcode).toList();
        emit(state.copyWith(
          isDeleting: false,
          allUsers: updatedList,
          filteredUsers: _filter(updatedList, state.searchQuery),
          actionMessage: 'User deleted successfully',
        ));
      },
      failure: (msg) {
        emit(state.copyWith(
          isDeleting: false,
          errorMessage: msg,
        ));
      },
    );
  }

  List<ManagedUser> _filter(List<ManagedUser> users, String query) {
    if (query.trim().isEmpty) return users;
    final q = query.toLowerCase().trim();
    return users.where((u) {
      return u.barcode.toLowerCase().contains(q) ||
          u.name.toLowerCase().contains(q) ||
          u.username.toLowerCase().contains(q) ||
          u.email.toLowerCase().contains(q) ||
          u.phone.toLowerCase().contains(q) ||
          u.role.toLowerCase().contains(q) ||
          u.factory.toLowerCase().contains(q) ||
          u.department.toLowerCase().contains(q) ||
          u.designation.toLowerCase().contains(q);
    }).toList();
  }
}
