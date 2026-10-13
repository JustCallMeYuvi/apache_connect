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


import 'package:apache_connect/data/datasources/documents_remote_data_source.dart';
import 'package:apache_connect/data/datasources/messages_remote_data_source.dart';
import 'package:apache_connect/data/repositories/documents_repository_impl.dart';
import 'package:apache_connect/data/repositories/messages_repository_impl.dart';
import 'package:apache_connect/domain/repositories/documents_repository.dart';
import 'package:apache_connect/domain/repositories/messages_repository.dart';
import 'package:apache_connect/domain/usecases/create_group_usecase.dart';
import 'package:apache_connect/domain/usecases/get_conversations_usecase.dart';
import 'package:apache_connect/domain/usecases/get_documents_usecase.dart';
import 'package:apache_connect/domain/usecases/send_message_usecase.dart';
import 'package:apache_connect/domain/usecases/upload_document_usecase.dart';
import 'package:apache_connect/presentation/bloc/documents/documents_bloc.dart';
import 'package:apache_connect/presentation/bloc/messages/messages_bloc.dart';
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
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
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

  // 2. Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
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
}
