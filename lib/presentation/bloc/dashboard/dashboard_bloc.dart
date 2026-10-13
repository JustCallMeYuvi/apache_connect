import 'package:apache_connect/domain/entities/dashboard_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_result.dart';
import '../../../domain/usecases/get_dashboard_data_usecase.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase _getDashboardDataUseCase;

  DashboardBloc({
    required GetDashboardDataUseCase getDashboardDataUseCase,
  })  : _getDashboardDataUseCase = getDashboardDataUseCase,
        super(const DashboardState()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<RefreshDashboardData>(_onRefreshDashboardData);
    on<SelectSidebarItem>(_onSelectSidebarItem);
    on<SelectBottomNavIndex>(_onSelectBottomNavIndex);
    on<ToggleDashboardTheme>(_onToggleTheme);
    on<TriggerQuickAction>(_onTriggerQuickAction);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        status: DashboardStatus.loading,
        errorMessage: null,
      ),
    );

    final result = await _getDashboardDataUseCase.execute();

    if (result is Success<DashboardData>) {
      emit(
        state.copyWith(
          status: DashboardStatus.success,
          data: result.data,
        ),
      );
    } else if (result is Failure<DashboardData>) {
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }

  Future<void> _onRefreshDashboardData(
    RefreshDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    final result = await _getDashboardDataUseCase.execute();

    if (result is Success<DashboardData>) {
      emit(
        state.copyWith(
          status: DashboardStatus.success,
          data: result.data,
          errorMessage: null,
        ),
      );
    } else if (result is Failure<DashboardData>) {
      emit(
        state.copyWith(
          status: DashboardStatus.failure,
          errorMessage: result.errorMessage,
        ),
      );
    }
  }

  void _onSelectSidebarItem(
    SelectSidebarItem event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedSidebarIndex: event.index));
  }

  void _onSelectBottomNavIndex(
    SelectBottomNavIndex event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedBottomNavIndex: event.index));
  }

  void _onToggleTheme(
    ToggleDashboardTheme event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }

  void _onTriggerQuickAction(
    TriggerQuickAction event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(lastTriggeredAction: event.actionName));
  }
}