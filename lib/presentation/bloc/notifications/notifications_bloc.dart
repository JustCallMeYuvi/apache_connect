// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/network/api_result.dart';
// import '../../../domain/usecases/delete_notification_usecase.dart';
// import '../../../domain/usecases/get_notifications_usecase.dart';
// import '../../../domain/usecases/mark_all_notifications_read_usecase.dart';
// import '../../../domain/usecases/mark_notification_read_usecase.dart';
// import 'notifications_event.dart';
// import 'notifications_state.dart';

// class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
//   final GetNotificationsUseCase getNotificationsUseCase;
//   final MarkNotificationReadUseCase markNotificationReadUseCase;
//   final MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase;
//   final DeleteNotificationUseCase deleteNotificationUseCase;

//   NotificationsBloc({
//     required this.getNotificationsUseCase,
//     required this.markNotificationReadUseCase,
//     required this.markAllNotificationsReadUseCase,
//     required this.deleteNotificationUseCase,
//   }) : super(const NotificationsState()) {
//     on<LoadNotificationsEvent>(_onLoadNotifications);
//     on<SelectNotificationEvent>(_onSelectNotification);
//     on<ToggleNotificationReadStatusEvent>(_onToggleReadStatus);
//     on<MarkNotificationReadEvent>(_onMarkRead);
//     on<MarkNotificationUnreadEvent>(_onMarkUnread);
//     on<MarkAllNotificationsReadEvent>(_onMarkAllRead);
//     on<DeleteNotificationEvent>(_onDeleteNotification);
//     on<ClearSelectedNotificationEvent>(_onClearSelected);
//   }

//   Future<void> _onLoadNotifications(
//     LoadNotificationsEvent event,
//     Emitter<NotificationsState> emit,
//   ) async {
//     emit(state.copyWith(status: NotificationsStatus.loading));
//     final result = await getNotificationsUseCase.execute();

//     if (result is Success) {
//       final list = (result as Success).data;
//       // Auto-select first notification or keep current
//       final selectedId = state.selectedNotificationId ?? (list.isNotEmpty ? list.first.id : null);
//       emit(state.copyWith(
//         status: NotificationsStatus.loaded,
//         notifications: list,
//         selectedNotificationId: selectedId,
//       ));
//     } else if (result is Failure) {
//       emit(state.copyWith(
//         status: NotificationsStatus.error,
//         errorMessage: (result as Failure).errorMessage,
//       ));
//     }
//   }

//   void _onSelectNotification(
//     SelectNotificationEvent event,
//     Emitter<NotificationsState> emit,
//   ) {
//     emit(state.copyWith(selectedNotificationId: event.id));
//   }

//   Future<void> _onToggleReadStatus(
//     ToggleNotificationReadStatusEvent event,
//     Emitter<NotificationsState> emit,
//   ) async {
//     final current = state.notifications.firstWhere(
//       (n) => n.id == event.id,
//       orElse: () => state.notifications.first,
//     );
//     if (current.isRead) {
//       add(MarkNotificationUnreadEvent(event.id));
//     } else {
//       add(MarkNotificationReadEvent(event.id));
//     }
//   }

//   Future<void> _onMarkRead(
//     MarkNotificationReadEvent event,
//     Emitter<NotificationsState> emit,
//   ) async {
//     final result = await markNotificationReadUseCase.executeRead(event.id);
//     if (result is Success) {
//       final updated = (result as Success).data;
//       final updatedList = state.notifications.map((n) {
//         return n.id == event.id ? updated : n;
//       }).toList();
//       emit(state.copyWith(
//         notifications: updatedList,
//         lastSuccessAction: 'marked_read',
//       ));
//     }
//   }

//   Future<void> _onMarkUnread(
//     MarkNotificationUnreadEvent event,
//     Emitter<NotificationsState> emit,
//   ) async {
//     final result = await markNotificationReadUseCase.executeUnread(event.id);
//     if (result is Success) {
//       final updated = (result as Success).data;
//       final updatedList = state.notifications.map((n) {
//         return n.id == event.id ? updated : n;
//       }).toList();
//       emit(state.copyWith(
//         notifications: updatedList,
//         lastSuccessAction: 'marked_unread',
//       ));
//     }
//   }

//   Future<void> _onMarkAllRead(
//     MarkAllNotificationsReadEvent event,
//     Emitter<NotificationsState> emit,
//   ) async {
//     final result = await markAllNotificationsReadUseCase.execute();
//     if (result is Success) {
//       final updatedList = state.notifications.map((n) {
//         return n.copyWith(isRead: true);
//       }).toList();
//       emit(state.copyWith(
//         notifications: updatedList,
//         lastSuccessAction: 'marked_all_read',
//       ));
//     }
//   }

//   Future<void> _onDeleteNotification(
//     DeleteNotificationEvent event,
//     Emitter<NotificationsState> emit,
//   ) async {
//     final result = await deleteNotificationUseCase.execute(event.id);
//     if (result is Success) {
//       final updatedList = state.notifications.where((n) => n.id != event.id).toList();
//       String? nextSelectedId = state.selectedNotificationId;
//       if (nextSelectedId == event.id) {
//         nextSelectedId = updatedList.isNotEmpty ? updatedList.first.id : null;
//       }
//       emit(state.copyWith(
//         notifications: updatedList,
//         selectedNotificationId: nextSelectedId,
//         clearSelectedNotification: nextSelectedId == null,
//         lastSuccessAction: 'deleted',
//       ));
//     }
//   }

//   void _onClearSelected(
//     ClearSelectedNotificationEvent event,
//     Emitter<NotificationsState> emit,
//   ) {
//     emit(state.copyWith(clearSelectedNotification: true));
//   }
// }

import 'package:apache_connect/domain/entities/app_notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_result.dart';
import '../../../domain/usecases/delete_notification_usecase.dart';
import '../../../domain/usecases/get_notifications_usecase.dart';
import '../../../domain/usecases/mark_all_notifications_read_usecase.dart';
import '../../../domain/usecases/mark_notification_read_usecase.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationReadUseCase markNotificationReadUseCase;
  final MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;

  NotificationsBloc({
    required this.getNotificationsUseCase,
    required this.markNotificationReadUseCase,
    required this.markAllNotificationsReadUseCase,
    required this.deleteNotificationUseCase,
  }) : super(const NotificationsState()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<SelectNotificationEvent>(_onSelectNotification);
    on<ToggleNotificationReadStatusEvent>(_onToggleReadStatus);
    on<MarkNotificationReadEvent>(_onMarkRead);
    on<MarkNotificationUnreadEvent>(_onMarkUnread);
    on<MarkAllNotificationsReadEvent>(_onMarkAllRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<ClearSelectedNotificationEvent>(_onClearSelected);
  }

  // Load notifications
  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    final result = await getNotificationsUseCase.execute();

    if (result is Success) {
      final List<AppNotification> notifications =
          (result as Success).data.cast<AppNotification>();

      final String? selectedId = state.selectedNotificationId ??
          (notifications.isNotEmpty ? notifications.first.id : null);

      emit(
        state.copyWith(
          status: NotificationsStatus.loaded,
          notifications: notifications,
          selectedNotificationId: selectedId,
        ),
      );
    } else if (result is Failure) {
      emit(
        state.copyWith(
          status: NotificationsStatus.error,
          errorMessage: (result as Failure).errorMessage,
        ),
      );
    }
  }

  // Select notification
  void _onSelectNotification(
    SelectNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state.copyWith(selectedNotificationId: event.id));
  }

  // Toggle notification read/unread status
  void _onToggleReadStatus(
    ToggleNotificationReadStatusEvent event,
    Emitter<NotificationsState> emit,
  ) {
    final int index = state.notifications.indexWhere(
      (notification) => notification.id == event.id,
    );

    if (index == -1) return;

    final AppNotification notification = state.notifications[index];

    if (notification.isRead) {
      add(MarkNotificationUnreadEvent(event.id));
    } else {
      add(MarkNotificationReadEvent(event.id));
    }
  }

  // Mark notification as read
  Future<void> _onMarkRead(
    MarkNotificationReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await markNotificationReadUseCase.executeRead(event.id);

    if (result is Success) {
      final AppNotification updated =
          (result as Success).data as AppNotification;

      final List<AppNotification> updatedList =
          state.notifications.map((notification) {
        return notification.id == event.id ? updated : notification;
      }).toList();

      emit(
        state.copyWith(
          notifications: updatedList,
          lastSuccessAction: 'marked_read',
        ),
      );
    } else if (result is Failure) {
      emit(
        state.copyWith(
          status: NotificationsStatus.error,
          errorMessage: (result as Failure).errorMessage,
        ),
      );
    }
  }

  // Mark notification as unread
  Future<void> _onMarkUnread(
    MarkNotificationUnreadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await markNotificationReadUseCase.executeUnread(event.id);

    if (result is Success) {
      final AppNotification updated =
          (result as Success).data as AppNotification;

      final List<AppNotification> updatedList =
          state.notifications.map((notification) {
        return notification.id == event.id ? updated : notification;
      }).toList();

      emit(
        state.copyWith(
          notifications: updatedList,
          lastSuccessAction: 'marked_unread',
        ),
      );
    } else if (result is Failure) {
      emit(
        state.copyWith(
          status: NotificationsStatus.error,
          errorMessage: (result as Failure).errorMessage,
        ),
      );
    }
  }

  // Mark all notifications as read
  Future<void> _onMarkAllRead(
    MarkAllNotificationsReadEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await markAllNotificationsReadUseCase.execute();

    if (result is Success) {
      final List<AppNotification> updatedList =
          state.notifications.map((notification) {
        return notification.copyWith(isRead: true);
      }).toList();

      emit(
        state.copyWith(
          notifications: updatedList,
          lastSuccessAction: 'marked_all_read',
        ),
      );
    } else if (result is Failure) {
      emit(
        state.copyWith(
          status: NotificationsStatus.error,
          errorMessage: (result).errorMessage,
        ),
      );
    }
  }

  // Delete notification
  Future<void> _onDeleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    final result = await deleteNotificationUseCase.execute(event.id);

    if (result is Success) {
      final List<AppNotification> updatedList = state.notifications
          .where((notification) => notification.id != event.id)
          .toList();

      String? nextSelectedId = state.selectedNotificationId;

      if (nextSelectedId == event.id) {
        nextSelectedId = updatedList.isNotEmpty ? updatedList.first.id : null;
      }

      emit(
        state.copyWith(
          notifications: updatedList,
          selectedNotificationId: nextSelectedId,
          clearSelectedNotification: nextSelectedId == null,
          lastSuccessAction: 'deleted',
        ),
      );
    } else if (result is Failure) {
      emit(
        state.copyWith(
          status: NotificationsStatus.error,
          errorMessage: (result).errorMessage,
        ),
      );
    }
  }

  // Clear selected notification
  void _onClearSelected(
    ClearSelectedNotificationEvent event,
    Emitter<NotificationsState> emit,
  ) {
    emit(state.copyWith(clearSelectedNotification: true));
  }
}
