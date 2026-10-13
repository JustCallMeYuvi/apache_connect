import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/app_document.dart';

class DocumentPreviewPanel extends StatefulWidget {
  final AppDocument document;
  final VoidCallback onClose;
  final bool isDarkMode;
  final bool isMobile;
  final VoidCallback? onDelete;

  const DocumentPreviewPanel({
    super.key,
    required this.document,
    required this.onClose,
    this.isDarkMode = false,
    this.isMobile = false,
    this.onDelete,
  });

  @override
  State<DocumentPreviewPanel> createState() => _DocumentPreviewPanelState();
}

class _DocumentPreviewPanelState extends State<DocumentPreviewPanel> {
  int _activeTabIndex = 0;

  Color _getExtensionBadgeColor(String extension) {
    switch (extension.toLowerCase()) {
      case 'xlsx':
      case 'xls':
        return const Color(0xFF10A760);
      case 'docx':
      case 'doc':
        return const Color(0xFF1D64F2);
      case 'pptx':
      case 'ppt':
        return const Color(0xFFE85D36);
      case 'pdf':
        return const Color(0xFFEF4444);
      default:
        return AppColors.primaryOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final doc = widget.document;
    final isDark = widget.isDarkMode;
    final badgeColor = _getExtensionBadgeColor(doc.extension);

    return Container(
      color: isDark ? const Color(0xFF0F172A) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Top Panel Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 12 : 24,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFF1F5F9),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                if (widget.isMobile) ...[
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                    color: isDark ? Colors.white : const Color(0xFF1F2937),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: widget.onClose,
                  ),
                  const SizedBox(width: 12),
                ],

                // Extension Badge
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    doc.extension.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Name and Version + Size
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        doc.name,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF1F2937),
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${doc.version} · ${doc.fileSize}',
                        style: TextStyle(
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Icons: Download, Share, Delete
                IconButton(
                  icon: const Icon(Icons.file_download_outlined, size: 21),
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF4B5563),
                  tooltip: 'Download',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Downloading ${doc.name}...'),
                        backgroundColor: AppColors.primaryOrange,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.file_upload_outlined, size: 21),
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF4B5563),
                  tooltip: 'Share',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Share link copied for ${doc.name}'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 21),
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF4B5563),
                  tooltip: 'Delete',
                  onPressed: () {
                    if (widget.onDelete != null) {
                      widget.onDelete!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Deleted ${doc.name}'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      widget.onClose();
                    }
                  },
                ),
              ],
            ),
          ),

          // 2. Tab Bar: Details | Versions (2) | Comments (101) | Sharing
          Container(
            padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 12 : 24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabItem(0, 'Details', isDark),
                  const SizedBox(width: 24),
                  _buildTabItem(1, 'Versions (${doc.versionsCount})', isDark),
                  const SizedBox(width: 24),
                  _buildTabItem(2, 'Comments (${doc.commentsCount})', isDark),
                  const SizedBox(width: 24),
                  _buildTabItem(3, 'Sharing', isDark),
                ],
              ),
            ),
          ),

          // 3. Tab Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(widget.isMobile ? 16 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Large Preview Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Large Icon Badge
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: badgeColor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            doc.extension.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Document Name
                        Text(
                          doc.name,
                          style: TextStyle(
                            color: isDark ? Colors.white : const Color(0xFF111827),
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 4),

                        // Preview notice subtitle matching screenshot
                        Text(
                          'Preview – demo file without stored content',
                          style: TextStyle(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Metadata Information Section matching exact screenshot layout
                  if (widget.isMobile)
                    _buildMobileMetadata(doc, isDark)
                  else
                    _buildDesktopMetadata(doc, isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label, bool isDark) {
    final isActive = _activeTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _activeTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primaryOrange : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive
                ? (isDark ? Colors.white : const Color(0xFFDE5227))
                : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF4B5563)),
            fontSize: 13.5,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Desktop multi-column metadata display
  Widget _buildDesktopMetadata(AppDocument doc, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: CATEGORY | OWNER | CURRENT VERSION | MODIFIED BY | MODIFIED
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildMetaField('CATEGORY', doc.category, isDark)),
            Expanded(child: _buildMetaField('OWNER', doc.owner, isDark)),
            Expanded(child: _buildMetaField('CURRENT VERSION', doc.version, isDark)),
            Expanded(child: _buildMetaField('MODIFIED BY', doc.modifiedBy, isDark)),
            Expanded(child: _buildMetaField('MODIFIED', doc.modifiedDate, isDark)),
          ],
        ),

        const SizedBox(height: 24),

        // Row 2: SIZE | YOUR ACCESS
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildMetaField('SIZE', doc.fileSize, isDark)),
            Expanded(
              flex: 4,
              child: _buildMetaField('YOUR ACCESS', doc.access, isDark),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Row 3: DESCRIPTION
        _buildMetaField('DESCRIPTION', doc.description, isDark),
      ],
    );
  }

  /// Mobile stacked metadata display
  Widget _buildMobileMetadata(AppDocument doc, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _buildMetaField('CATEGORY', doc.category, isDark)),
            Expanded(child: _buildMetaField('OWNER', doc.owner, isDark)),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _buildMetaField('CURRENT VERSION', doc.version, isDark)),
            Expanded(child: _buildMetaField('MODIFIED BY', doc.modifiedBy, isDark)),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _buildMetaField('MODIFIED', doc.modifiedDate, isDark)),
            Expanded(child: _buildMetaField('SIZE', doc.fileSize, isDark)),
          ],
        ),
        const SizedBox(height: 18),
        _buildMetaField('YOUR ACCESS', doc.access, isDark),
        const SizedBox(height: 18),
        _buildMetaField('DESCRIPTION', doc.description, isDark),
      ],
    );
  }

  Widget _buildMetaField(String label, String value, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF1F2937),
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
