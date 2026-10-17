import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/datasources/access_control_data_source.dart';
import '../../domain/entities/document_access_entry.dart';

/// Reusable "Who can access this file?" selector widget
/// Supports searching roles and employees, multi-select checkboxes, and badges.
class DocumentAccessSelector extends StatefulWidget {
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onSelectionChanged;
  final bool isDarkMode;

  const DocumentAccessSelector({
    super.key,
    required this.selectedIds,
    required this.onSelectionChanged,
    this.isDarkMode = false,
  });

  @override
  State<DocumentAccessSelector> createState() => _DocumentAccessSelectorState();
}

class _DocumentAccessSelectorState extends State<DocumentAccessSelector> {
  final TextEditingController _searchController = TextEditingController();
  final AccessControlDataSource _dataSource = AccessControlDataSourceImpl();

  List<DocumentAccessEntry> _allEntries = [];
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await _dataSource.getAllAccessEntries();
    if (mounted) {
      setState(() {
        _allEntries = entries;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSelection(String id) {
    final newSet = Set<String>.from(widget.selectedIds);
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    widget.onSelectionChanged(newSet);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    final filteredEntries = _allEntries.where((entry) {
      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.toLowerCase().trim();
      return entry.name.toLowerCase().contains(q) ||
          entry.detail.toLowerCase().contains(q) ||
          (entry.department?.toLowerCase().contains(q) ?? false) ||
          (entry.emailOrId?.toLowerCase().contains(q) ?? false) ||
          (entry.designation?.toLowerCase().contains(q) ?? false);
    }).toList();

    final filteredRoles = filteredEntries.where((e) => e.isRole).toList();
    final filteredEmployees = filteredEntries.where((e) => e.isEmployee).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section Header
        Text(
          'Who can access this file?',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.textDark,
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4),

        // Subtitle note
        Text(
          'Tick roles or employees, then choose what each can do. If nothing is ticked, only you and admins can see the file.',
          style: TextStyle(
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            fontSize: 12,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 10),

        // Search Field
        Container(
          height: 42,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? const Color(0x22FFFFFF) : const Color(0xFFE2E8F0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.textDark,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search roles, employees...',
                    hintStyle: TextStyle(
                      color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                ),
              ),
              if (_searchQuery.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // List Content
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryOrange,
                ),
              ),
            ),
          )
        else if (filteredEntries.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'No matching roles or employees found',
                style: TextStyle(
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  fontSize: 12.5,
                ),
              ),
            ),
          )
        else ...[
          // Roles / authority section (if any roles match)
          if (filteredRoles.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 6, top: 2),
              child: Text(
                'Roles / authority',
                style: TextStyle(
                  color: isDark ? Colors.white70 : AppColors.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...filteredRoles.map((role) => _buildEntryRow(role, isDark)),
            if (filteredEmployees.isNotEmpty) const SizedBox(height: 8),
          ],

          // Employees section (if any employees match)
          if (filteredEmployees.isNotEmpty) ...[
            if (filteredRoles.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 4),
                child: Text(
                  'Employees',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ...filteredEmployees.map((emp) => _buildEntryRow(emp, isDark)),
          ],
        ],
      ],
    );
  }

  Widget _buildEntryRow(DocumentAccessEntry entry, bool isDark) {
    final isSelected = widget.selectedIds.contains(entry.id);

    return InkWell(
      onTap: () => _toggleSelection(entry.id),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        child: Row(
          children: [
            // Custom-styled Checkbox matching screenshot
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: isSelected,
                activeColor: AppColors.primaryOrange,
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: BorderSide(
                  color: isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1),
                  width: 1.5,
                ),
                onChanged: (_) => _toggleSelection(entry.id),
              ),
            ),
            const SizedBox(width: 10),

            // Text info
            Expanded(
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: entry.name,
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' · ${entry.detail}',
                      style: TextStyle(
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Role / Employee Pill Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                entry.isRole ? 'Role' : 'Employee',
                style: TextStyle(
                  color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
