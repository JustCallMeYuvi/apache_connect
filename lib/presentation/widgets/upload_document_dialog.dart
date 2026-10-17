import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/document_file_picker_service.dart';
import '../bloc/documents/documents_bloc.dart';
import '../bloc/documents/documents_event.dart';
import 'document_access_selector.dart';

/// Complete, responsive Upload Document Dialog matching reference screenshots
/// for both Desktop/Web and Mobile viewports.
class UploadDocumentDialog extends StatefulWidget {
  final bool isDarkMode;

  const UploadDocumentDialog({
    super.key,
    this.isDarkMode = false,
  });

  static Future<bool?> show({
    required BuildContext context,
    bool isDarkMode = false,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 640;

    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 24,
          vertical: isMobile ? 16 : 24,
        ),
        child: UploadDocumentDialog(isDarkMode: isDarkMode),
      ),
    );
  }

  @override
  State<UploadDocumentDialog> createState() => _UploadDocumentDialogState();
}

class _UploadDocumentDialogState extends State<UploadDocumentDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  PickedDocumentFile? _selectedFile;
  String _selectedCategory = 'Finance';
  Set<String> _selectedAccessIds = {};
  String? _fileError;
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Finance',
    'Safety',
    'Operations',
    'Compliance',
    'HR',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleChooseFile() async {
    try {
      final pickedFile = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: DocumentFilePickerService.allowedExtensions,
      );

      if (pickedFile == null) return; // user cancelled

      // bytes/size are no longer eager getters, so read them explicitly.
      final bytes = await pickedFile.readAsBytes();

      final validation = DocumentFilePickerService.validateFile(
        fileName: pickedFile.name,
        sizeInBytes: bytes.length,
        bytes: bytes,
      );

      if (!mounted) return;

      if (!validation.isValid) {
        setState(() => _fileError = validation.errorMessage);
        return;
      }

      setState(() {
        _selectedFile = validation.file;
        _fileError = null;
        if (_nameController.text.trim().isEmpty) {
          _nameController.text = pickedFile.name;
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _fileError = 'Unable to select file. Please try again.');
      debugPrint('File picker error: $e');
    }
  }
  //       return Padding(
  //         padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Select document file',
  //                   style: TextStyle(
  //                     color: isDark ? Colors.white : AppColors.textDark,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //                 IconButton(
  //                   icon: const Icon(Icons.close, size: 20),
  //                   onPressed: () => Navigator.of(bottomSheetCtx).pop(),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 10),
  //             ...samples.map((sample) {
  //               return ListTile(
  //                 contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //                 leading: Container(
  //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                   decoration: BoxDecoration(
  //                     color: AppColors.primaryOrange.withValues(alpha: 0.12),
  //                     borderRadius: BorderRadius.circular(6),
  //                   ),
  //                   child: Text(
  //                     sample.extension.toUpperCase(),
  //                     style: const TextStyle(
  //                       color: AppColors.primaryOrange,
  //                       fontWeight: FontWeight.w800,
  //                       fontSize: 11,
  //                     ),
  //                   ),
  //                 ),
  //                 title: Text(
  //                   sample.name,
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: TextStyle(
  //                     color: isDark ? Colors.white : AppColors.textDark,
  //                     fontSize: 13.5,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 subtitle: Text(
  //                   sample.formattedSize,
  //                   style: TextStyle(
  //                     color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
  //                     fontSize: 12,
  //                   ),
  //                 ),
  //                 onTap: () {
  //                   Navigator.of(bottomSheetCtx).pop();
  //                   setState(() {
  //                     _selectedFile = sample;
  //                     _fileError = null;
  //                   });
  //                 },
  //               );
  //             }),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _handleSubmit() async {
    if (_isSubmitting) return;

    if (_selectedFile == null) {
      setState(() {
        _fileError = 'Please choose a file to upload';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _fileError = null;
    });

    final enteredName = _nameController.text.trim();
    final displayName =
        enteredName.isNotEmpty ? enteredName : _selectedFile!.name;

    final description = _descriptionController.text.trim();

    // Trigger upload event in DocumentsBloc
    context.read<DocumentsBloc>().add(
          UploadDocumentEvent(
            name: displayName,
            category: _selectedCategory,
            extension: _selectedFile!.extension,
            fileSize: _selectedFile!.formattedSize,
            description: description.isNotEmpty
                ? description
                : 'Uploaded corporate $_selectedCategory document.', bytes: _selectedFile!.bytes!,
          ),
        );

    // Simulated short network transition
    await Future.delayed(const Duration(milliseconds: 350));

    if (mounted) {
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document "$displayName" uploaded successfully'),
          backgroundColor: AppColors.primaryOrange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDark = widget.isDarkMode;

    final dialogWidth = isMobile ? size.width * 0.95 : 560.0;
    final maxHeight = size.height * 0.90;

    return Container(
      width: dialogWidth,
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Header: Title + Close Icon
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload document',
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.textDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  splashRadius: 18,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0x18000000)),

          // 2. Scrollable Body Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // File Field Label
                  Text(
                    'File',
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // File Selection Box
                  InkWell(
                    onTap: _handleChooseFile,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _fileError != null
                              ? AppColors.error
                              : (isDark
                                  ? const Color(0x22FFFFFF)
                                  : const Color(0xFFE2E8F0)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0x22FFFFFF)
                                    : const Color(0xFFCBD5E1),
                              ),
                            ),
                            child: Text(
                              'Choose File',
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1E293B),
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _selectedFile != null
                                  ? _selectedFile!.name
                                  : 'No file chosen',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: _selectedFile != null
                                    ? (isDark
                                        ? Colors.white
                                        : AppColors.textDark)
                                    : (isDark
                                        ? const Color(0xFF64748B)
                                        : const Color(0xFF94A3B8)),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_fileError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 2),
                      child: Text(
                        _fileError!,
                        style: const TextStyle(
                            color: AppColors.error, fontSize: 11.5),
                      ),
                    ),

                  const SizedBox(height: 14),

                  // Display Name (optional)
                  Text(
                    'Display name (optional)',
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameController,
                    style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontSize: 13.5),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          isDark ? const Color(0xFF0F172A) : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 11),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(0x22FFFFFF)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(0x22FFFFFF)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.primaryOrange, width: 1.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Category Dropdown
                  Text(
                    'Category',
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0F172A) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark
                            ? const Color(0x22FFFFFF)
                            : const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 20),
                        dropdownColor:
                            isDark ? const Color(0xFF1E293B) : Colors.white,
                        style: TextStyle(
                          color: isDark ? Colors.white : AppColors.textDark,
                          fontSize: 13.5,
                        ),
                        items: _categories.map((c) {
                          return DropdownMenuItem<String>(
                              value: c, child: Text(c));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedCategory = val);
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Description Field
                  Text(
                    'Description',
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 2,
                    style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textDark,
                        fontSize: 13.5),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          isDark ? const Color(0xFF0F172A) : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(0x22FFFFFF)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: isDark
                              ? const Color(0x22FFFFFF)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.primaryOrange, width: 1.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Allowed Formats & Max Size Information
                  Text(
                    'Allowed: pdf,doc,docx,xls,xlsx,ppt,pptx,txt,csv,png,jpg,jpeg · max 5 MB',
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 3. Access Control Section ("Who can access this file?")
                  DocumentAccessSelector(
                    selectedIds: _selectedAccessIds,
                    isDarkMode: isDark,
                    onSelectionChanged: (set) {
                      setState(() => _selectedAccessIds = set);
                    },
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0x18000000)),

          // 4. Action Buttons (Cancel and Upload)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel button
                TextButton(
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.of(context).pop(false),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : AppColors.textDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Upload button
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Upload',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
