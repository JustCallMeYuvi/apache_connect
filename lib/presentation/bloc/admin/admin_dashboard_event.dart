import 'package:equatable/equatable.dart';

abstract class AdminDashboardEvent extends Equatable {
  const AdminDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadAdminStatsEvent extends AdminDashboardEvent {
  const LoadAdminStatsEvent();
}

class RefreshAdminStatsEvent extends AdminDashboardEvent {
  const RefreshAdminStatsEvent();
}

class SelectAdminItemEvent extends AdminDashboardEvent {
  final String itemId;

  const SelectAdminItemEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
