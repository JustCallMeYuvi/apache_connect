import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_result.dart';
import '../../../domain/entities/admin_stat_item.dart';
import '../../../domain/usecases/get_admin_stats_usecase.dart';
import 'admin_dashboard_event.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final GetAdminStatsUseCase _getAdminStatsUseCase;

  AdminDashboardBloc({
    required GetAdminStatsUseCase getAdminStatsUseCase,
  })  : _getAdminStatsUseCase = getAdminStatsUseCase,
        super(const AdminDashboardState()) {
    on<LoadAdminStatsEvent>(_onLoadAdminStats);
    on<RefreshAdminStatsEvent>(_onRefreshAdminStats);
    on<SelectAdminItemEvent>(_onSelectAdminItem);
  }

  Future<void> _onLoadAdminStats(
    LoadAdminStatsEvent event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(state.copyWith(status: AdminDashboardStatus.loading));

    final result = await _getAdminStatsUseCase.execute();

    if (result is Success<List<AdminStatItem>>) {
      emit(state.copyWith(
        status: AdminDashboardStatus.success,
        items: result.data,
      ));
    } else if (result is Failure<List<AdminStatItem>>) {
      emit(state.copyWith(
        status: AdminDashboardStatus.failure,
        errorMessage: result.errorMessage,
      ));
    }
  }

  Future<void> _onRefreshAdminStats(
    RefreshAdminStatsEvent event,
    Emitter<AdminDashboardState> emit,
  ) async {
    final result = await _getAdminStatsUseCase.execute();

    if (result is Success<List<AdminStatItem>>) {
      emit(state.copyWith(
        status: AdminDashboardStatus.success,
        items: result.data,
      ));
    } else if (result is Failure<List<AdminStatItem>>) {
      emit(state.copyWith(
        status: AdminDashboardStatus.failure,
        errorMessage: result.errorMessage,
      ));
    }
  }

  void _onSelectAdminItem(
    SelectAdminItemEvent event,
    Emitter<AdminDashboardState> emit,
  ) {
    emit(state.copyWith(selectedItemId: event.itemId));
  }
}
