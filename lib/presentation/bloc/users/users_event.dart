import 'package:equatable/equatable.dart';
import '../../../domain/entities/managed_user.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsersEvent extends UsersEvent {
  const LoadUsersEvent();
}

class SearchUsersEvent extends UsersEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ChangePageEvent extends UsersEvent {
  final int page;

  const ChangePageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class LoadFactoriesEvent extends UsersEvent {
  const LoadFactoriesEvent();
}

class SelectFactoryForNewUserEvent extends UsersEvent {
  final String factory;

  const SelectFactoryForNewUserEvent(this.factory);

  @override
  List<Object?> get props => [factory];
}

class SelectEmployeeForNewUserEvent extends UsersEvent {
  final EmployeeLookup employee;

  const SelectEmployeeForNewUserEvent(this.employee);

  @override
  List<Object?> get props => [employee];
}

class ResetNewUserFormEvent extends UsersEvent {
  const ResetNewUserFormEvent();
}

class CreateUserEvent extends UsersEvent {
  final ManagedUser user;

  const CreateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUserEvent extends UsersEvent {
  final ManagedUser user;

  const UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class ToggleUserStatusEvent extends UsersEvent {
  final String barcode;
  final bool currentStatus;

  const ToggleUserStatusEvent({
    required this.barcode,
    required this.currentStatus,
  });

  @override
  List<Object?> get props => [barcode, currentStatus];
}

class DeleteUserEvent extends UsersEvent {
  final String barcode;

  const DeleteUserEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}
