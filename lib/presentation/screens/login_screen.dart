import 'package:apache_connect/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../widgets/brand_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/glass_container.dart';
import '../widgets/keep_signed_in_checkbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Pre-populate with screenshot default values for instant preview fidelity
    _usernameController = TextEditingController(text: 'Yuvi');
    _passwordController = TextEditingController(text: '••••••••');

    // Notify BLoC of initial pre-filled values
    context
        .read<LoginBloc>()
        .add(LoginUsernameChanged(_usernameController.text));
    context
        .read<LoginBloc>()
        .add(LoginPasswordChanged(_passwordController.text));
  }

  @override
  void dispose() {
    _usernameController.dispose;
    _passwordController.dispose;
    super.dispose();
  }

  void _handleForgotPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text(
          'Password Recovery',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'A reset link has been dispatched to your Apache workspace administrator for user "${_usernameController.text}".',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK',
                style: TextStyle(color: AppColors.primaryOrange)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppDimens.mobileBreakpoint;

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        // listener: (context, state) {
        //   if (state.isFailure && state.errorMessage != null) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(state.errorMessage!),
        //         backgroundColor: AppColors.error,
        //         behavior: SnackBarBehavior.floating,
        //       ),
        //     );
        //   } else if (state.isSuccess) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text('${AppStrings.loginSuccess} (ID: ${state.authenticatedUser?.id})'),
        //         backgroundColor: AppColors.success,
        //         behavior: SnackBarBehavior.floating,
        //       ),
        //     );
        //   }
        // },

        // listener: (context, state) {
        //   if (state.isFailure && state.errorMessage != null) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(state.errorMessage!),
        //         backgroundColor: AppColors.error,
        //         behavior: SnackBarBehavior.floating,
        //       ),
        //     );
        //   } else if (state.isSuccess) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(
        //           '${AppStrings.loginSuccess} '
        //           '(ID: ${state.authenticatedUser?.id})',
        //         ),
        //         backgroundColor: AppColors.success,
        //         behavior: SnackBarBehavior.floating,
        //       ),
        //     );

        //     Navigator.pushReplacementNamed(
        //       context,
        //       // AppRoutes.dashboard,
        //       AppRoutes.main,
        //     );
        //   }
        // },

        listener: (context, state) {
          if (state.isFailure && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          // else if (state.isSuccess) {
          //   Navigator.of(context).pushReplacementNamed(
          //     AppRoutes.main,
          //   );
          // }
          else if (state.isSuccess) {
            final employeeId = state.authenticatedUser?.id;

            // Remove any existing SnackBar before navigating.
            ScaffoldMessenger.of(context).clearSnackBars();

            Navigator.of(context).pushReplacementNamed(
              AppRoutes.main,
            );

            // Show the success message after navigation.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final messenger = ScaffoldMessenger.maybeOf(context);

              messenger?.showSnackBar(
                SnackBar(
                  content: Text(
                    '${AppStrings.loginSuccess} (ID: $employeeId)',
                  ),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            });
          }
        },

        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Full-screen campus background image
              Image.asset(
                AppAssets.campusBackground,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to high-res network image if asset isn't compiled in bundle
                  return Image.network(
                    AppAssets.fallbackBackground,
                    fit: BoxFit.cover,
                  );
                },
              ),

              // 2. Dark contrast overlay & vignette for optimal readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Colors.black.withOpacity(0.35),
                      Colors.black.withValues(alpha: 0.5),

                      // Colors.black.withOpacity(0.45),
                      Colors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),

              // 3. Responsive Login Card
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 18.0 : 32.0,
                      vertical: 24.0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile
                            ? double.infinity
                            : AppDimens.desktopCardWidth,
                      ),
                      child: GlassContainer(
                        padding: EdgeInsets.all(
                          isMobile
                              ? AppDimens.cardPaddingMobile
                              : AppDimens.cardPaddingDesktop,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Apache Connect Brand Header
                            const BrandHeader(),

                            const SizedBox(height: AppDimens.spacingLg),

                            // Username / Email input field
                            CustomTextField(
                              label: AppStrings.usernameOrEmailLabel,
                              hintText: AppStrings.usernamePlaceholder,
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              errorText: state.usernameError,
                              onChanged: (val) {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginUsernameChanged(val));
                              },
                              textInputAction: TextInputAction.next,
                            ),

                            const SizedBox(height: AppDimens.spacingMd + 2),

                            // Password input field with visibility toggle
                            CustomTextField(
                              label: AppStrings.passwordLabel,
                              hintText: AppStrings.passwordPlaceholder,
                              controller: _passwordController,
                              obscureText: state.isPasswordObscured,
                              errorText: state.passwordError,
                              onChanged: (val) {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginPasswordChanged(val));
                              },
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                context
                                    .read<LoginBloc>()
                                    .add(const LoginSubmitted());
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.isPasswordObscured
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.textSecondary,
                                  size: 20,
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        const LoginPasswordVisibilityToggled(),
                                      );
                                },
                              ),
                            ),

                            const SizedBox(height: AppDimens.spacingMd),

                            // "Keep me signed in" checkbox and "Forgot password?"
                            KeepSignedInAndForgotRow(
                              isChecked: state.rememberMe,
                              onCheckedChanged: (val) {
                                context
                                    .read<LoginBloc>()
                                    .add(LoginRememberMeToggled(val));
                              },
                              onForgotPasswordPressed: () =>
                                  _handleForgotPassword(context),
                            ),

                            const SizedBox(height: AppDimens.spacingLg),

                            // Orange "Sign in" Button
                            CustomButton(
                              text: AppStrings.signInButton,
                              isLoading: state.isLoading,
                              onPressed: () {
                                context
                                    .read<LoginBloc>()
                                    .add(const LoginSubmitted());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
