import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/managed_user.dart';
import '../bloc/users/users_bloc.dart';
import '../bloc/users/users_event.dart';
import '../bloc/users/users_state.dart';
import '../widgets/user_card.dart';
import '../widgets/user_form_dialog.dart';
import '../widgets/users_pagination.dart';
import '../widgets/users_search_field.dart';
import '../widgets/users_table.dart';

class UsersScreen extends StatefulWidget {
  final ValueChanged<int>? onNavItemSelected;

  const UsersScreen({
    super.key,
    this.onNavItemSelected,
  });

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<UsersBloc>();
    bloc.add(const LoadUsersEvent());
    bloc.add(const LoadFactoriesEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openAddUserDialog(BuildContext context, UsersState state) {
    final bloc = context.read<UsersBloc>();
    bloc.add(const ResetNewUserFormEvent());

    final isMobile = MediaQuery.of(context).size.width < 768;

    UserFormDialog.show(
      context: context,
      factories: state.factories,
      availableEmployees: state.availableEmployees,
      selectedFactory: state.selectedFactory,
      selectedEmployee: state.selectedEmployee,
      onFactoryChanged: (factory) {
        bloc.add(SelectFactoryForNewUserEvent(factory));
      },
      onEmployeeSelected: (emp) {
        bloc.add(SelectEmployeeForNewUserEvent(emp));
      },
      onSave: (user) async {
        bloc.add(CreateUserEvent(user));
      },
      isDarkMode: _isDarkMode,
      isMobile: isMobile,
    );
  }

  void _openEditUserDialog(
      BuildContext context, ManagedUser user, UsersState state) {
    final bloc = context.read<UsersBloc>();
    final isMobile = MediaQuery.of(context).size.width < 768;

    UserFormDialog.show(
      context: context,
      userToEdit: user,
      factories: state.factories,
      availableEmployees: state.availableEmployees,
      selectedFactory: user.factory,
      onFactoryChanged: (factory) {
        bloc.add(SelectFactoryForNewUserEvent(factory));
      },
      onEmployeeSelected: (emp) {
        bloc.add(SelectEmployeeForNewUserEvent(emp));
      },
      onSave: (updatedUser) async {
        bloc.add(UpdateUserEvent(updatedUser));
      },
      isDarkMode: _isDarkMode,
      isMobile: isMobile,
    );
  }

  void _confirmDeleteUser(BuildContext context, ManagedUser user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete user',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${user.name} (${user.barcode})? This action cannot be undone.',
          style: TextStyle(
            color:
                _isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
            fontSize: 13.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: _isDarkMode ? Colors.white70 : AppColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<UsersBloc>().add(DeleteUserEvent(user.barcode));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              'Delete',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 992;
    final isMobile = screenWidth < 768;

    return BlocConsumer<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state.actionMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.actionMessage!),
              backgroundColor: AppColors.primaryOrange,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        // return AppScaffold(
        // title: 'Users',
        // activeNavIndex: 5, // Highlight Users in sidebar
        // isDarkMode: _isDarkMode,
        // onThemeToggle: () {
        //   setState(() {
        //     _isDarkMode = !_isDarkMode;
        //   });
        // },
        // body:
        return Container(
          color:
              _isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF7F5F0),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: isMobile ? 18 : 26,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Page Header: "Users" title + Orange "+ Add" Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Users',
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: _isDarkMode ? Colors.white : AppColors.textDark,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _openAddUserDialog(context, state),
                      icon: const Icon(Icons.add_rounded,
                          size: 18, color: Colors.white),
                      label: isMobile
                          ? const SizedBox.shrink()
                          : const Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 18,
                          vertical: isMobile ? 10 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Search Field with record counter
                UsersSearchField(
                  controller: _searchController,
                  onChanged: (query) {
                    context.read<UsersBloc>().add(SearchUsersEvent(query));
                  },
                  currentRecords: state.filteredUsers.length,
                  totalRecords: state.allUsers.length,
                  isDarkMode: _isDarkMode,
                ),

                const SizedBox(height: 18),

                // Loading indicator or Table / Cards
                if (state.status == UsersStatus.loading &&
                    state.allUsers.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  )
                else if (isDesktop)
                  // Desktop Horizontally Scrollable Table
                  UsersTable(
                    users: state.paginatedUsers,
                    isDarkMode: _isDarkMode,
                    onEdit: (u) => _openEditUserDialog(context, u, state),
                    onToggleStatus: (u) {
                      context.read<UsersBloc>().add(
                            ToggleUserStatusEvent(
                              barcode: u.barcode,
                              currentStatus: u.isActive,
                            ),
                          );
                    },
                    onDelete: (u) => _confirmDeleteUser(context, u),
                  )
                else
                  // Mobile Vertically Stacked User Cards
                  Column(
                    children: state.paginatedUsers.map((user) {
                      return UserCard(
                        user: user,
                        isDarkMode: _isDarkMode,
                        onEdit: (u) => _openEditUserDialog(context, u, state),
                        onToggleStatus: (u) {
                          context.read<UsersBloc>().add(
                                ToggleUserStatusEvent(
                                  barcode: u.barcode,
                                  currentStatus: u.isActive,
                                ),
                              );
                        },
                        onDelete: (u) => _confirmDeleteUser(context, u),
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 10),

                // Pagination controls
                UsersPagination(
                  startIndex: state.startIndexDisplay,
                  endIndex: state.endIndexDisplay,
                  totalRecords: state.totalRecords,
                  currentPage: state.currentPage,
                  totalPages: state.totalPages,
                  onPageChanged: (page) {
                    context.read<UsersBloc>().add(ChangePageEvent(page));
                  },
                  isDarkMode: _isDarkMode,
                ),

                if (isMobile) const SizedBox(height: 60),
              ],
            ),
          ),
        );
        // );
      },
    );
  }
}
