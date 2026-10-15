import 'package:equatable/equatable.dart';
import '../../../domain/entities/admin_stat_item.dart';

enum AdminDashboardStatus {
  initial,
  loading,
  success,
  failure,
}

class AdminDashboardState extends Equatable {
  final AdminDashboardStatus status;
  final List<AdminStatItem> items;
  final String? selectedItemId;
  final String? errorMessage;

  const AdminDashboardState({
    this.status = AdminDashboardStatus.initial,
    this.items = const [],
    this.selectedItemId,
    this.errorMessage,
  });

  bool get isLoading => status == AdminDashboardStatus.loading;
  bool get isSuccess => status == AdminDashboardStatus.success;
  bool get isFailure => status == AdminDashboardStatus.failure;

  AdminStatItem? get selectedItem {
    if (selectedItemId == null) return null;
    try {
      return items.firstWhere((item) => item.id == selectedItemId);
    } catch (_) {
      return null;
    }
  }

  AdminDashboardState copyWith({
    AdminDashboardStatus? status,
    List<AdminStatItem>? items,
    String? selectedItemId,
    String? errorMessage,
  }) {
    return AdminDashboardState(
      status: status ?? this.status,
      items: items ?? this.items,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        selectedItemId,
        errorMessage,
      ];
}
