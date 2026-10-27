import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/managed_user.dart';

class UserFormDialog extends StatefulWidget {
  final ManagedUser? userToEdit;
  final List<String> factories;
  final List<EmployeeLookup> availableEmployees;
  final String? selectedFactory;
  final EmployeeLookup? selectedEmployee;
  final ValueChanged<String> onFactoryChanged;
  final ValueChanged<EmployeeLookup> onEmployeeSelected;
  final Future<void> Function(ManagedUser user) onSave;
  final bool isDarkMode;
  final bool isMobile;

  const UserFormDialog({
    super.key,
    this.userToEdit,
    required this.factories,
    required this.availableEmployees,
    this.selectedFactory,
    this.selectedEmployee,
    required this.onFactoryChanged,
    required this.onEmployeeSelected,
    required this.onSave,
    required this.isDarkMode,
    this.isMobile = false,
  });

  static Future<void> show({
    required BuildContext context,
    ManagedUser? userToEdit,
    required List<String> factories,
    required List<EmployeeLookup> availableEmployees,
    String? selectedFactory,
    EmployeeLookup? selectedEmployee,
    required ValueChanged<String> onFactoryChanged,
    required ValueChanged<EmployeeLookup> onEmployeeSelected,
    required Future<void> Function(ManagedUser user) onSave,
    required bool isDarkMode,
    required bool isMobile,
  }) async {
    if (isMobile) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => UserFormDialog(
          userToEdit: userToEdit,
          factories: factories,
          availableEmployees: availableEmployees,
          selectedFactory: selectedFactory,
          selectedEmployee: selectedEmployee,
          onFactoryChanged: onFactoryChanged,
          onEmployeeSelected: onEmployeeSelected,
          onSave: onSave,
          isDarkMode: isDarkMode,
          isMobile: true,
        ),
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black54,
        builder: (ctx) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: UserFormDialog(
              userToEdit: userToEdit,
              factories: factories,
              availableEmployees: availableEmployees,
              selectedFactory: selectedFactory,
              selectedEmployee: selectedEmployee,
              onFactoryChanged: onFactoryChanged,
              onEmployeeSelected: onEmployeeSelected,
              onSave: onSave,
              isDarkMode: isDarkMode,
              isMobile: false,
            ),
          ),
        ),
      );
    }
  }

  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late String? _factory;
  late String? _barcode;
  late TextEditingController _fullNameController;
  late TextEditingController _departmentController;
  late TextEditingController _designationController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final edit = widget.userToEdit;

    _factory = edit?.factory ?? widget.selectedFactory;
    _barcode = edit?.barcode ?? widget.selectedEmployee?.barcode;

    _fullNameController = TextEditingController(text: edit?.name ?? widget.selectedEmployee?.name ?? '');
    _departmentController = TextEditingController(text: edit?.department ?? widget.selectedEmployee?.department ?? '—');
    _designationController = TextEditingController(text: edit?.designation ?? widget.selectedEmployee?.designation ?? '—');
    _usernameController = TextEditingController(text: edit?.username ?? '');
    _emailController = TextEditingController(text: edit?.email ?? widget.selectedEmployee?.defaultEmail ?? '');
    _phoneController = TextEditingController(text: edit?.phone ?? widget.selectedEmployee?.defaultPhone ?? '');
  }

  @override
  void didUpdateWidget(UserFormDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedEmployee != null && widget.selectedEmployee != oldWidget.selectedEmployee) {
      final emp = widget.selectedEmployee!;
      _barcode = emp.barcode;
      _fullNameController.text = emp.name;
      _departmentController.text = emp.department;
      _designationController.text = emp.designation;
      if (_usernameController.text.isEmpty) {
        _usernameController.text = '${emp.name.split(' ').first}@${emp.barcode.replaceAll(RegExp(r'[^0-9]'), '')}';
      }
      if (_emailController.text.isEmpty && emp.defaultEmail.isNotEmpty) {
        _emailController.text = emp.defaultEmail;
      }
      if (_phoneController.text.isEmpty && emp.defaultPhone.isNotEmpty) {
        _phoneController.text = emp.defaultPhone;
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _departmentController.dispose();
    _designationController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_factory == null || _factory!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a factory/company'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_barcode == null || _barcode!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an employee barcode'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final user = ManagedUser(
        barcode: _barcode!,
        name: _fullNameController.text.trim(),
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        role: widget.userToEdit?.role ?? 'Employee',
        factory: _factory!,
        department: _departmentController.text.trim(),
        designation: _designationController.text.trim(),
        locationStatus: widget.userToEdit?.locationStatus ?? 'Anywhere',
        location: widget.userToEdit?.location ?? '—',
        isActive: widget.userToEdit?.isActive ?? true,
      );

      await widget.onSave(user);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final isEdit = widget.userToEdit != null;

    final content = Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: widget.isMobile
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: widget.isMobile
            ? MediaQuery.of(context).viewInsets.bottom + 20
            : 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header: Title + Close Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEdit ? 'Edit user' : 'Add user',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    color: isDark ? Colors.white70 : const Color(0xFF64748B),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // 1. Factory / company dropdown
              _buildFieldLabel('Factory / company', isDark),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0F172A) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? const Color(0x2AFFFFFF) : const Color(0xFFCBD5E1),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _factory,
                    hint: Text(
                      'Select factory...',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                      ),
                    ),
                    isExpanded: true,
                    dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark ? Colors.white70 : const Color(0xFF64748B),
                    ),
                    items: widget.factories.map((f) {
                      return DropdownMenuItem<String>(
                        value: f,
                        child: Text(
                          f,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white : AppColors.textDark,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: isEdit
                        ? null
                        : (val) {
                            if (val != null) {
                              setState(() {
                                _factory = val;
                                _barcode = null;
                                _fullNameController.clear();
                                _departmentController.text = '—';
                                _designationController.text = '—';
                              });
                              widget.onFactoryChanged(val);
                            }
                          },
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 2. Employee barcode dropdown
              _buildFieldLabel('Employee barcode', isDark),
              Container(
                decoration: BoxDecoration(
                  color: (_factory == null && !isEdit)
                      ? (isDark ? const Color(0xFF151D2A) : const Color(0xFFF1F5F9))
                      : (isDark ? const Color(0xFF0F172A) : Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? const Color(0x2AFFFFFF) : const Color(0xFFCBD5E1),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _barcode,
                    hint: Text(
                      _factory == null && !isEdit
                          ? 'Select factory first'
                          : 'Select employee barcode',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                      ),
                    ),
                    isExpanded: true,
                    dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark ? Colors.white70 : const Color(0xFF64748B),
                    ),
                    items: isEdit
                        ? [
                            DropdownMenuItem(
                              value: _barcode,
                              child: Text(
                                _barcode ?? '',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.white : AppColors.textDark,
                                ),
                              ),
                            ),
                          ]
                        : widget.availableEmployees.map((emp) {
                            return DropdownMenuItem<String>(
                              value: emp.barcode,
                              child: Text(
                                '${emp.barcode} • ${emp.name}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.white : AppColors.textDark,
                                ),
                              ),
                            );
                          }).toList(),
                    onChanged: (_factory == null || isEdit)
                        ? null
                        : (val) {
                            if (val != null) {
                              final match = widget.availableEmployees.firstWhere((e) => e.barcode == val);
                              setState(() {
                                _barcode = val;
                              });
                              widget.onEmployeeSelected(match);
                            }
                          },
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // 3. Full name (auto)
              _buildFieldLabel('Full name (auto)', isDark),
              _buildTextInput(
                controller: _fullNameController,
                placeholder: 'Filled from barcode',
                isDark: isDark,
                readOnly: true,
              ),

              const SizedBox(height: 14),

              // 4. Department (auto)
              _buildFieldLabel('Department (auto)', isDark),
              _buildTextInput(
                controller: _departmentController,
                placeholder: '—',
                isDark: isDark,
                readOnly: true,
              ),

              const SizedBox(height: 14),

              // 5. Designation (auto)
              _buildFieldLabel('Designation (auto)', isDark),
              _buildTextInput(
                controller: _designationController,
                placeholder: '—',
                isDark: isDark,
                readOnly: true,
              ),

              const SizedBox(height: 14),

              // 6. Username
              _buildFieldLabel('Username', isDark),
              _buildTextInput(
                controller: _usernameController,
                placeholder: 'e.g. Imran@67657',
                isDark: isDark,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 14),

              // 7. Email
              _buildFieldLabel('Email', isDark),
              _buildTextInput(
                controller: _emailController,
                placeholder: 'e.g. imran@apache.co',
                isDark: isDark,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Email is required';
                  }
                  if (!val.contains('@') || !val.contains('.')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 14),

              // 8. Phone
              _buildFieldLabel('Phone', isDark),
              _buildTextInput(
                controller: _phoneController,
                placeholder: 'e.g. +91 90000 01000',
                isDark: isDark,
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Footer Buttons: Cancel & Save
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel button
                  TextButton(
                    onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isDark ? const Color(0x2AFFFFFF) : const Color(0xFFCBD5E1),
                        ),
                      ),
                      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : AppColors.textDark,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Save button
                  ElevatedButton(
                    onPressed: _isSaving ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            isEdit ? 'Update' : 'Save',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return content;
  }

  Widget _buildFieldLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String placeholder,
    required bool isDark,
    bool readOnly = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        fontSize: 13,
        color: readOnly
            ? (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B))
            : (isDark ? Colors.white : AppColors.textDark),
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 13,
          color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
        ),
        filled: true,
        fillColor: readOnly
            ? (isDark ? const Color(0xFF151D2A) : const Color(0xFFF8FAFC))
            : (isDark ? const Color(0xFF0F172A) : Colors.white),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDark ? const Color(0x2AFFFFFF) : const Color(0xFFCBD5E1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isDark ? const Color(0x2AFFFFFF) : const Color(0xFFCBD5E1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryOrange,
            width: 1.5,
          ),
        ),
        isDense: true,
      ),
    );
  }
}
