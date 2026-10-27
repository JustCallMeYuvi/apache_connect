import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/managed_user.dart';

class UserCard extends StatelessWidget {
  final ManagedUser user;
  final bool isDarkMode;
  final ValueChanged<ManagedUser> onEdit;
  final ValueChanged<ManagedUser> onToggleStatus;
  final ValueChanged<ManagedUser> onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.isDarkMode,
    required this.onEdit,
    required this.onToggleStatus,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        children: [
          _buildRow('Barcode', user.barcode, isBold: true),
          _buildDivider(),
          _buildRow('Name', user.name),
          _buildDivider(),
          _buildRow('Username', user.username),
          _buildDivider(),
          _buildRow('Email', user.email),
          _buildDivider(),
          _buildRow('Phone', user.phone),
          _buildDivider(),
          _buildRow('Role', user.role),
          _buildDivider(),
          _buildRow('Factory', user.factory),
          _buildDivider(),
          _buildRow('Department', user.department),
          _buildDivider(),
          _buildRow('Designation', user.designation),
          _buildDivider(),
          _buildCustomRow(
            'Location status',
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF133824) : const Color(0xFFE6F4EA),
                borderRadius: BorderRadius.circular(10),
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
          _buildDivider(),
          _buildRow('Location', user.location),
          _buildDivider(),
          _buildCustomRow(
            'Active',
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
              decoration: BoxDecoration(
                color: user.isActive
                    ? (isDarkMode ? const Color(0xFF133824) : const Color(0xFFE6F4EA))
                    : (isDarkMode ? const Color(0xFF3B1C1C) : const Color(0xFFFDE8E8)),
                borderRadius: BorderRadius.circular(10),
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
          _buildDivider(),
          // Actions row
          _buildCustomRow(
            'Actions',
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => onToggleStatus(user),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
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
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF64748B),
                  onPressed: () => onEdit(user),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF64748B),
                  onPressed: () => onDelete(user),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppColors.textDark,
                fontSize: 13,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomRow(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 8,
      thickness: 0.5,
      color: isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFF1F5F9),
    );
  }
}
