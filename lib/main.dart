// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'core/constants/app_strings.dart';
// import 'core/di/injection_container.dart' as di;
// import 'core/theme/app_theme.dart';
// import 'presentation/bloc/login/login_bloc.dart';
// import 'presentation/screens/login_screen.dart';
// import 'routes/app_routes.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Clean Architecture dependency injection container
//   await di.initDependencies();

//   runApp(const ApacheConnectApp());
// }

// class ApacheConnectApp extends StatelessWidget {
//   const ApacheConnectApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (context) => di.sl<LoginBloc>(),
//       child: MaterialApp(
//         title: AppStrings.appTitle,
//         debugShowCheckedModeBanner: false,
//         theme: AppTheme.darkTheme,
//         initialRoute: AppRoutes.login,
//         routes: AppRoutes.routes,
//         home: const LoginScreen(),
//       ),
//     );
//   }
// }

import 'package:apache_connect/presentation/bloc/documents/documents_bloc.dart';
import 'package:apache_connect/presentation/bloc/messages/messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_strings.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'presentation/bloc/dashboard/dashboard_bloc.dart';
import 'presentation/bloc/login/login_bloc.dart';
import 'presentation/screens/login_screen.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Clean Architecture dependency injection container
  await di.initDependencies();

  runApp(const ApacheConnectApp());
}

class ApacheConnectApp extends StatelessWidget {
  const ApacheConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => di.sl<LoginBloc>(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => di.sl<DashboardBloc>(),
        ),
        BlocProvider<MessagesBloc>(
          create: (_) => di.sl<MessagesBloc>(),
        ),
        BlocProvider<DocumentsBloc>(
          create: (_) => di.sl<DocumentsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
        home: const LoginScreen(),
      ),
    );
  }
}
