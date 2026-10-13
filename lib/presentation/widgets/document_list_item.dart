import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/app_document.dart';

class DocumentListItem extends StatelessWidget {
  final AppDocument document;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDarkMode;

  const DocumentListItem({
    super.key,
    required this.document,
    this.isSelected = false,
    required this.onTap,
    this.isDarkMode = false,
  });

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
    final badgeColor = _getExtensionBadgeColor(document.extension);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? const Color(0xFF283348) : const Color(0xFFECEEF2))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // File Type Badge Square
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                document.extension.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Filename & Metadata Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    document.name,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : const Color(0xFF1F2937),
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${document.category} · ${document.version} · ${document.date}',
                    style: TextStyle(
                      color: isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF6B7280),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
