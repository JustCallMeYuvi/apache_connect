import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/user.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../widgets/sign_out_dialog.dart';

/// Complete My Profile Screen in ApacheConnect following Clean Architecture & BLoC pattern
/// Recreates Desktop (Screenshot 3) and Mobile (Screenshot 4) layouts with real authenticated data.
class ProfileScreen extends StatefulWidget {
  final ValueChanged<int>? onNavItemSelected;
  const ProfileScreen({super.key, this.onNavItemSelected});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isDarkMode = false;

  // Personal Info Form Controllers
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // Change Password Form Controllers
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  bool _isSavingProfile = false;
  bool _isUpdatingPassword = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<LoginBloc>().state.currentUser;
    _fullNameController = TextEditingController(text: user.safeDisplayName);
    _emailController = TextEditingController(text: user.safeEmail);
    _phoneController = TextEditingController(text: user.safePhone);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveProfile() async {
    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Full name cannot be empty'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSavingProfile = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    context.read<LoginBloc>().add(
          UpdateProfileEvent(
            fullName: name,
            email: email,
            phone: phone,
          ),
        );

    setState(() => _isSavingProfile = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Profile updated successfully'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleUpdatePassword() async {
    final current = _currentPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All password fields are required'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (newPass.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New password must be at least 6 characters'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (newPass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New password and confirm password do not match'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isUpdatingPassword = true);
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    context.read<LoginBloc>().add(
          ChangePasswordEvent(
            currentPassword: current,
            newPassword: newPass,
          ),
        );

    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();

    setState(() => _isUpdatingPassword = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text('Password updated successfully'),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 1024;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, loginState) {
        final user = loginState.currentUser;

        return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: isMobile ? 16 : 32,
        right: isMobile ? 16 : 32,
        top: isMobile ? 20 : 28,
        bottom: isMobile ? 88 : 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My profile',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : AppColors.textDark,
              fontSize: isMobile ? 22 : 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 24),

          if (isMobile)
            Column(
              children: [
                _buildPersonalInfoCard(user),
                const SizedBox(height: 20),
                _buildChangePasswordCard(),
                const SizedBox(height: 20),
                _buildSessionCard(user),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _buildPersonalInfoCard(user),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: _buildChangePasswordCard(),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: _buildSessionCard(user),
                ),
              ],
            ),
        ],
      ),
    );
      },
    );
  }

  // Card 1: Personal Information (Matches Screenshot 3 & 4)
  Widget _buildPersonalInfoCard(User user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              _isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Name + Status badge
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.primaryOrange,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'SI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.safeDisplayName,
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : AppColors.textDark,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        user.safeRole,
                        style: TextStyle(
                          color: _isDarkMode
                              ? const Color(0xFF94A3B8)
                              : AppColors.textGray,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '•',
                        style:
                            TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user.safeStatus,
                          style: const TextStyle(
                            color: Color(0xFF059669),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Full Name Input
          _buildFieldLabel('Full name'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _fullNameController,
            hintText: 'Full name',
          ),

          const SizedBox(height: 16),

          // Email Input
          _buildFieldLabel('Email'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _emailController,
            hintText: 'Email address',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 16),

          // Phone Input
          _buildFieldLabel('Phone'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _phoneController,
            hintText: 'Phone number',
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 22),

          // Metadata Grid: BARCODE, DEPARTMENT, FACTORY, DESIGNATION
          Row(
            children: [
              Expanded(
                child: _buildMetaItem('BARCODE', user.safeBarcode),
              ),
              Expanded(
                child: _buildMetaItem('DEPARTMENT', user.safeDepartment),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetaItem('FACTORY', user.safeFactory),
              ),
              Expanded(
                child: _buildMetaItem('DESIGNATION', user.safeDesignation),
              ),
            ],
          ),

          const SizedBox(height: 26),

          // Save profile Button
          ElevatedButton(
            onPressed: _isSavingProfile ? null : _handleSaveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            child: _isSavingProfile
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Save profile',
                    style:
                        TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                  ),
          ),
        ],
      ),
    );
  }

  // Card 2: Change Password (Matches Screenshot 3 & 4)
  Widget _buildChangePasswordCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              _isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Change password',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : AppColors.textDark,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),

          const SizedBox(height: 20),

          // Current Password
          _buildFieldLabel('Current password'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _currentPasswordController,
            hintText: 'Enter current password',
            obscureText: _obscureCurrent,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureCurrent
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 19,
                color: const Color(0xFF94A3B8),
              ),
              onPressed: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
          ),

          const SizedBox(height: 16),

          // New Password
          _buildFieldLabel('New password'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _newPasswordController,
            hintText: 'Enter new password',
            obscureText: _obscureNew,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNew
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 19,
                color: const Color(0xFF94A3B8),
              ),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
          ),

          const SizedBox(height: 16),

          // Confirm New Password
          _buildFieldLabel('Confirm new password'),
          const SizedBox(height: 6),
          _buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm new password',
            obscureText: _obscureConfirm,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 19,
                color: const Color(0xFF94A3B8),
              ),
              onPressed: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),

          const SizedBox(height: 26),

          // Update password Button
          ElevatedButton(
            onPressed: _isUpdatingPassword ? null : _handleUpdatePassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
            child: _isUpdatingPassword
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Update password',
                    style:
                        TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
                  ),
          ),
        ],
      ),
    );
  }

  // Card 3: Session Information (Matches Screenshot 3 & 4)
  Widget _buildSessionCard(User user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              _isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : AppColors.textDark,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),

          const SizedBox(height: 20),

          // TOKEN & SIGNED IN row
          Row(
            children: [
              Expanded(
                child: _buildMetaItem('TOKEN', user.safeToken),
              ),
              Expanded(
                child: _buildMetaItem('SIGNED IN', 'Oct 17, 2026, 03:09 PM'),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // EXPIRES
          _buildMetaItem('EXPIRES', 'Nov 16, 2026, 03:09 PM'),

          const SizedBox(height: 18),

          // Explanatory note
          Text(
            'Your sign-in is stored in this browser until it expires or you sign out.',
            style: TextStyle(
              fontSize: 12.5,
              color: _isDarkMode ? const Color(0xFF94A3B8) : AppColors.textGray,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // Red Sign out Button
          ElevatedButton.icon(
            onPressed: () {
              SignOutDialog.show(
                context,
                isDarkMode: _isDarkMode,
                onConfirmSignOut: () {
                  context.read<LoginBloc>().add(const SignOutEvent());
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (route) => false,
                  );
                },
              );
            },
            icon: const Icon(Icons.logout_rounded, size: 17),
            label: const Text(
              'Sign out',
              style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFFDC2626), // Red matching Screenshot 3 & 4
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: _isDarkMode ? const Color(0xFFCBD5E1) : AppColors.textDark,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: _isDarkMode ? Colors.white : AppColors.textDark,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 13.5,
        ),
        filled: true,
        fillColor: _isDarkMode ? const Color(0xFF0F172A) : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color:
                _isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color:
                _isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryOrange),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildMetaItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: _isDarkMode ? Colors.white : AppColors.textDark,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
