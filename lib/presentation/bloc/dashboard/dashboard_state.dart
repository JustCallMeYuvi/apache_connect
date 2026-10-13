import 'package:equatable/equatable.dart';
import '../../../domain/entities/dashboard_data.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final DashboardData? data;
  final int selectedSidebarIndex;
  final int selectedBottomNavIndex;
  final bool isDarkMode;
  final String? errorMessage;
  final String? lastTriggeredAction;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.data,
    this.selectedSidebarIndex = 0, // 0 = Dashboard
    this.selectedBottomNavIndex = 0, // 0 = Home
    this.isDarkMode = false,
    this.errorMessage,
    this.lastTriggeredAction,
  });

  bool get isLoading => status == DashboardStatus.loading;
  bool get isSuccess => status == DashboardStatus.success;
  bool get isFailure => status == DashboardStatus.failure;

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardData? data,
    int? selectedSidebarIndex,
    int? selectedBottomNavIndex,
    bool? isDarkMode,
    String? errorMessage,
    String? lastTriggeredAction,
    bool clearAction = false,
  }) {
    return DashboardState(
      status: status ?? this.status,
      data: data ?? this.data,
      selectedSidebarIndex: selectedSidebarIndex ?? this.selectedSidebarIndex,
      selectedBottomNavIndex: selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      errorMessage: errorMessage ?? this.errorMessage,
      lastTriggeredAction: clearAction ? null : (lastTriggeredAction ?? this.lastTriggeredAction),
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        selectedSidebarIndex,
        selectedBottomNavIndex,
        isDarkMode,
        errorMessage,
        lastTriggeredAction,
      ];
}
