// import 'package:get_it/get_it.dart';
// import '../../data/datasources/auth_remote_data_source.dart';
// import '../../data/repositories/auth_repository_impl.dart';
// import '../../domain/repositories/auth_repository.dart';
// import '../../domain/usecases/login_usecase.dart';
// import '../../presentation/bloc/login/login_bloc.dart';

// final sl = GetIt.instance;

// Future<void> initDependencies() async {
//   // 1. Data Sources
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(),
//   );

//   // 2. Repositories
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(remoteDataSource: sl()),
//   );

//   // 3. Use Cases
//   sl.registerLazySingleton<LoginUseCase>(
//     () => LoginUseCase(sl()),
//   );

//   // 4. BLoCs (Factory so new instances are provided if rebuilt)
//   sl.registerFactory<LoginBloc>(
//     () => LoginBloc(loginUseCase: sl()),
//   );

  


  
// }


import 'package:apache_connect/core/network/dio_client.dart';
import 'package:apache_connect/data/datasources/admin_remote_data_source.dart';
import 'package:apache_connect/data/datasources/documents_remote_data_source.dart';
import 'package:apache_connect/data/datasources/messages_remote_data_source.dart';
import 'package:apache_connect/data/datasources/notifications_remote_data_source.dart';
import 'package:apache_connect/data/datasources/users_remote_data_source.dart';
import 'package:apache_connect/data/repositories/admin_repository_impl.dart';
import 'package:apache_connect/data/repositories/documents_repository_impl.dart';
import 'package:apache_connect/data/repositories/messages_repository_impl.dart';
import 'package:apache_connect/data/repositories/notifications_repository_impl.dart';
import 'package:apache_connect/data/repositories/users_repository_impl.dart';
import 'package:apache_connect/domain/repositories/admin_repository.dart';
import 'package:apache_connect/domain/repositories/documents_repository.dart';
import 'package:apache_connect/domain/repositories/messages_repository.dart';
import 'package:apache_connect/domain/repositories/notifications_repository.dart';
import 'package:apache_connect/domain/repositories/users_repository.dart';
import 'package:apache_connect/domain/usecases/create_group_usecase.dart';
import 'package:apache_connect/domain/usecases/delete_notification_usecase.dart';
import 'package:apache_connect/domain/usecases/get_admin_stats_usecase.dart';
import 'package:apache_connect/domain/usecases/get_conversations_usecase.dart';
import 'package:apache_connect/domain/usecases/get_documents_usecase.dart';
import 'package:apache_connect/domain/usecases/get_notifications_usecase.dart';
import 'package:apache_connect/domain/usecases/manage_user_usecases.dart';
import 'package:apache_connect/domain/usecases/mark_all_notifications_read_usecase.dart';
import 'package:apache_connect/domain/usecases/mark_notification_read_usecase.dart';
import 'package:apache_connect/domain/usecases/send_message_usecase.dart';
import 'package:apache_connect/domain/usecases/upload_document_usecase.dart';
import 'package:apache_connect/presentation/bloc/admin/admin_dashboard_bloc.dart';
import 'package:apache_connect/presentation/bloc/documents/documents_bloc.dart';
import 'package:apache_connect/presentation/bloc/messages/messages_bloc.dart';
import 'package:apache_connect/presentation/bloc/notifications/notifications_bloc.dart';
import 'package:apache_connect/presentation/bloc/users/users_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_data_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/bloc/dashboard/dashboard_bloc.dart';
import '../../presentation/bloc/login/login_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // 1. Data Sources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(),
  // );
  sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(
    dio: DioClient.instance,
  ),
);

  sl.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(),
    
  );

   sl.registerLazySingleton<MessagesRemoteDataSource>(
    () => MessagesRemoteDataSourceImpl(),
  );

    sl.registerLazySingleton<DocumentsRemoteDataSource>(
    () => DocumentsRemoteDataSourceImpl(),
  );
   sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<AdminRemoteDataSource>(
    () => AdminRemoteDataSourceImpl(),
  );


  // 2. Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

    sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(remoteDataSource: sl()),
  );
   sl.registerLazySingleton<MessagesRepository>(
    () => MessagesRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<DocumentsRepository>(
    () => DocumentsRepositoryImpl(remoteDataSource: sl()),
  );
   sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(remoteDataSource: sl()),
  );

    sl.registerLazySingleton<AdminRepository>(
    () => AdminRepositoryImpl(remoteDataSource: sl()),
  );
  // 3. Use Cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl()),
  );
  sl.registerLazySingleton<GetDashboardDataUseCase>(
    () => GetDashboardDataUseCase(sl()),
  );
   sl.registerLazySingleton<GetConversationsUseCase>(
    () => GetConversationsUseCase(sl()),
  );
  sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(sl()),
  );
  sl.registerLazySingleton<CreateGroupUseCase>(
    () => CreateGroupUseCase(sl()),
  );

    sl.registerLazySingleton<GetDocumentsUseCase>(
    () => GetDocumentsUseCase(sl()),
  );
  sl.registerLazySingleton<UploadDocumentUseCase>(
    () => UploadDocumentUseCase(sl()),
  );


  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl()),
  );
  sl.registerLazySingleton<MarkNotificationReadUseCase>(
    () => MarkNotificationReadUseCase(sl()),
  );
  sl.registerLazySingleton<MarkAllNotificationsReadUseCase>(
    () => MarkAllNotificationsReadUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteNotificationUseCase>(
    () => DeleteNotificationUseCase(sl()),
  );

  sl.registerLazySingleton<GetAdminStatsUseCase>(
    () => GetAdminStatsUseCase(sl()),
  );



  sl.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(sl()),
  );
  sl.registerLazySingleton<CreateUserUseCase>(
    () => CreateUserUseCase(sl()),
  );
  sl.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(sl()),
  );
  sl.registerLazySingleton<ToggleUserStatusUseCase>(
    () => ToggleUserStatusUseCase(sl()),
  );
  sl.registerLazySingleton<DeleteUserUseCase>(
    () => DeleteUserUseCase(sl()),
  );
  sl.registerLazySingleton<GetFactoriesUseCase>(
    () => GetFactoriesUseCase(sl()),
  );
  sl.registerLazySingleton<GetEmployeesByFactoryUseCase>(
    () => GetEmployeesByFactoryUseCase(sl()),
  );

  // 4. BLoCs (Factory so fresh state is maintained per session)
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: sl()),
  );
  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(getDashboardDataUseCase: sl()),
  );

    sl.registerFactory<MessagesBloc>(
    () => MessagesBloc(
      getConversationsUseCase: sl(),
      sendMessageUseCase: sl(),
      createGroupUseCase: sl(),
    ),
  );

   sl.registerFactory<DocumentsBloc>(
    () => DocumentsBloc(
      getDocumentsUseCase: sl(),
      uploadDocumentUseCase: sl(),
    ),
  );

  
  sl.registerFactory<NotificationsBloc>(
    () => NotificationsBloc(
      getNotificationsUseCase: sl(),
      markNotificationReadUseCase: sl(),
      markAllNotificationsReadUseCase: sl(),
      deleteNotificationUseCase: sl(),
    ),
  );

    sl.registerFactory<AdminDashboardBloc>(
    () => AdminDashboardBloc(
      getAdminStatsUseCase: sl(),
    ),
  );

  
  sl.registerFactory<UsersBloc>(
    () => UsersBloc(
      getUsersUseCase: sl(),
      createUserUseCase: sl(),
      updateUserUseCase: sl(),
      toggleUserStatusUseCase: sl(),
      deleteUserUseCase: sl(),
      getFactoriesUseCase: sl(),
      getEmployeesByFactoryUseCase: sl(),
    ),
  );
}
