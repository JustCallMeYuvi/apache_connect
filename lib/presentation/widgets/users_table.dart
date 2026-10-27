import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/managed_user.dart';

class UsersTable extends StatelessWidget {
  final List<ManagedUser> users;
  final bool isDarkMode;
  final ValueChanged<ManagedUser> onEdit;
  final ValueChanged<ManagedUser> onToggleStatus;
  final ValueChanged<ManagedUser> onDelete;

  const UsersTable({
    super.key,
    required this.users,
    required this.isDarkMode,
    required this.onEdit,
    required this.onToggleStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: 44,
              color: isDarkMode ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 12),
            Text(
              'No users found',
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppColors.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Try adjusting your search criteria or add a new user.',
              style: TextStyle(
                color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 1100),
            child: DataTable(
              headingRowHeight: 48,
              dataRowMinHeight: 64,
              dataRowMaxHeight: 74,
              horizontalMargin: 20,
              columnSpacing: 22,
              headingRowColor: WidgetStateProperty.all(
                isDarkMode ? const Color(0xFF161F2E) : const Color(0xFFF8FAFC),
              ),
              columns: [
                _buildHeaderColumn('BARCODE'),
                _buildHeaderColumn('NAME'),
                _buildHeaderColumn('USERNAME'),
                _buildHeaderColumn('EMAIL'),
                _buildHeaderColumn('PHONE'),
                _buildHeaderColumn('ROLE'),
                _buildHeaderColumn('FACTORY'),
                _buildHeaderColumn('DEPARTMENT'),
                _buildHeaderColumn('DESIGNATION'),
                _buildHeaderColumn('LOCATION STATUS'),
                _buildHeaderColumn('LOCATION'),
                _buildHeaderColumn('ACTIVE'),
                _buildHeaderColumn('ACTIONS'),
              ],
              rows: users.map((user) => _buildDataRow(user)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _buildHeaderColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  DataRow _buildDataRow(ManagedUser user) {
    return DataRow(
      cells: [
        // Barcode (Bold)
        DataCell(
          Text(
            user.barcode,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
              color: isDarkMode ? Colors.white : AppColors.textDark,
            ),
          ),
        ),

        // Name
        DataCell(
          Text(
            user.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : AppColors.textDark,
            ),
          ),
        ),

        // Username
        DataCell(
          Text(
            user.username,
            style: TextStyle(
              fontSize: 12.5,
              color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
        ),

        // Email
        DataCell(
          Text(
            user.email,
            style: TextStyle(
              fontSize: 12.5,
              color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
        ),

        // Phone
        DataCell(
          Text(
            user.phone,
            style: TextStyle(
              fontSize: 12.5,
              color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
        ),

        // Role
        DataCell(
          Text(
            user.role,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : AppColors.textDark,
            ),
          ),
        ),

        // Factory
        DataCell(
          Text(
            user.factory,
            style: TextStyle(
              fontSize: 12.5,
              color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
        ),

        // Department
        DataCell(
          Text(
            user.department,
            style: TextStyle(
              fontSize: 12.5,
              color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
        ),

        // Designation
        DataCell(
          Text(
            user.designation,
            style: TextStyle(
              fontSize: 12.5,
              color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
        ),

        // Location Status (Pill)
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF133824) : const Color(0xFFE6F4EA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.locationStatus,
              style: TextStyle(
                color: isDarkMode ? const Color(0xFF34D399) : const Color(0xFF137333),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Location
        DataCell(
          Text(
            user.location,
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ),

        // Active Status (Pill)
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: user.isActive
                  ? (isDarkMode ? const Color(0xFF133824) : const Color(0xFFE6F4EA))
                  : (isDarkMode ? const Color(0xFF3B1C1C) : const Color(0xFFFDE8E8)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.isActive ? 'Active' : 'Inactive',
              style: TextStyle(
                color: user.isActive
                    ? (isDarkMode ? const Color(0xFF34D399) : const Color(0xFF137333))
                    : (isDarkMode ? const Color(0xFFF87171) : const Color(0xFFC81E1E)),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // Actions
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Deactivate / Activate button
              InkWell(
                onTap: () => onToggleStatus(user),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDarkMode ? const Color(0x2AFFFFFF) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    user.isActive ? 'Deactivate' : 'Activate',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : AppColors.textDark,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Edit Icon
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 18),
                color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF64748B),
                tooltip: 'Edit user',
                onPressed: () => onEdit(user),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),

              const SizedBox(width: 4),

              // Delete Icon
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF64748B),
                tooltip: 'Delete user',
                onPressed: () => onDelete(user),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
