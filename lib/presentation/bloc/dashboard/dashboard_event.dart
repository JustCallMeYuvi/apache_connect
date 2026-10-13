import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Triggered when the dashboard is opened to load data
class LoadDashboardData extends DashboardEvent {
  const LoadDashboardData();
}

/// Triggered when the user pulls down or clicks refresh
class RefreshDashboardData extends DashboardEvent {
  const RefreshDashboardData();
}

/// Triggered when user selects a navigation item on desktop sidebar
class SelectSidebarItem extends DashboardEvent {
  final int index;
  const SelectSidebarItem(this.index);

  @override
  List<Object?> get props => [index];
}

/// Triggered when user clicks a tab in the mobile bottom navigation bar
class SelectBottomNavIndex extends DashboardEvent {
  final int index;
  const SelectBottomNavIndex(this.index);

  @override
  List<Object?> get props => [index];
}

/// Triggered when theme toggle is clicked
class ToggleDashboardTheme extends DashboardEvent {
  const ToggleDashboardTheme();
}

/// Triggered when user clicks one of the quick actions (New chat, Upload doc, My profile)
class TriggerQuickAction extends DashboardEvent {
  final String actionName;
  const TriggerQuickAction(this.actionName);

  @override
  List<Object?> get props => [actionName];
}
