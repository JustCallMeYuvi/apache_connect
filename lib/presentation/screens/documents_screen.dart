// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/constants/app_strings.dart';
// import '../../domain/entities/app_document.dart';
// import '../../routes/app_routes.dart';
// import '../bloc/documents/documents_bloc.dart';
// import '../bloc/documents/documents_event.dart';
// import '../bloc/documents/documents_state.dart';
// import '../widgets/dashboard_bottom_nav.dart';
// import '../widgets/dashboard_sidebar.dart';
// import '../widgets/document_category_dropdown.dart';
// import '../widgets/document_empty_preview.dart';
// import '../widgets/document_list_item.dart';
// import '../widgets/document_preview_panel.dart';
// import '../widgets/document_search_field.dart';

// class DocumentsScreen extends StatefulWidget {
//   const DocumentsScreen({super.key});

//   @override
//   State<DocumentsScreen> createState() => _DocumentsScreenState();
// }

// class _DocumentsScreenState extends State<DocumentsScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _searchController = TextEditingController();
//   bool _isDarkMode = false;

//   @override
//   void initState() {
//     super.initState();
//     final bloc = context.read<DocumentsBloc>();
//     if (bloc.state.status == DocumentsStatus.initial) {
//       bloc.add(const LoadDocumentsEvent());
//     }
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _showUploadDialog(BuildContext context) {
//     final nameController = TextEditingController();
//     String selectedCategory = 'Finance';
//     String selectedFormat = 'xlsx';
//     final categories = ['Finance', 'Safety', 'Operations', 'Compliance'];
//     final formats = ['xlsx', 'docx', 'pptx', 'pdf'];

//     showDialog(
//       context: context,
//       builder: (ctx) => StatefulBuilder(
//         builder: (ctx, setDialogState) {
//           final isDark = _isDarkMode;
//           return AlertDialog(
//             backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             title: Text(
//               AppStrings.uploadDocumentDialogTitle,
//               style: TextStyle(
//                 color: isDark ? Colors.white : const Color(0xFF1F2937),
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             content: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     AppStrings.documentNameLabel,
//                     style: TextStyle(
//                       color: isDark
//                           ? const Color(0xFF94A3B8)
//                           : const Color(0xFF6B7280),
//                       fontSize: 12.5,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   TextField(
//                     controller: nameController,
//                     autofocus: true,
//                     style: TextStyle(
//                         color: isDark ? Colors.white : const Color(0xFF1F2937)),
//                     decoration: InputDecoration(
//                       hintText: 'e.g. Budget-Q4',
//                       hintStyle: TextStyle(
//                         color: isDark
//                             ? const Color(0xFF64748B)
//                             : const Color(0xFF9CA3AF),
//                         fontSize: 14,
//                       ),
//                       filled: true,
//                       fillColor: isDark
//                           ? const Color(0xFF0F172A)
//                           : const Color(0xFFF9FAFB),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 14, vertical: 12),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: isDark
//                               ? const Color(0x22FFFFFF)
//                               : const Color(0xFFE5E7EB),
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: isDark
//                               ? const Color(0x22FFFFFF)
//                               : const Color(0xFFE5E7EB),
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: const BorderSide(color: Color(0xFFDE5227)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     AppStrings.categoryDropdownLabel,
//                     style: TextStyle(
//                       color: isDark
//                           ? const Color(0xFF94A3B8)
//                           : const Color(0xFF6B7280),
//                       fontSize: 12.5,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       color: isDark
//                           ? const Color(0xFF0F172A)
//                           : const Color(0xFFF9FAFB),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: isDark
//                             ? const Color(0x22FFFFFF)
//                             : const Color(0xFFE5E7EB),
//                       ),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: selectedCategory,
//                         isExpanded: true,
//                         dropdownColor:
//                             isDark ? const Color(0xFF1E293B) : Colors.white,
//                         style: TextStyle(
//                           color:
//                               isDark ? Colors.white : const Color(0xFF1F2937),
//                           fontSize: 14,
//                         ),
//                         items: categories.map((c) {
//                           return DropdownMenuItem<String>(
//                               value: c, child: Text(c));
//                         }).toList(),
//                         onChanged: (val) {
//                           if (val != null) {
//                             setDialogState(() => selectedCategory = val);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     AppStrings.fileTypeLabel,
//                     style: TextStyle(
//                       color: isDark
//                           ? const Color(0xFF94A3B8)
//                           : const Color(0xFF6B7280),
//                       fontSize: 12.5,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Wrap(
//                     spacing: 8,
//                     children: formats.map((fmt) {
//                       final isSelected = selectedFormat == fmt;
//                       return ChoiceChip(
//                         label: Text(fmt.toUpperCase()),
//                         selected: isSelected,
//                         selectedColor: const Color(0xFFDE5227),
//                         labelStyle: TextStyle(
//                           color: isSelected
//                               ? Colors.white
//                               : (isDark
//                                   ? Colors.white70
//                                   : const Color(0xFF374151)),
//                           fontWeight: FontWeight.w700,
//                           fontSize: 12,
//                         ),
//                         backgroundColor: isDark
//                             ? const Color(0xFF0F172A)
//                             : const Color(0xFFF3F4F6),
//                         onSelected: (sel) {
//                           if (sel) {
//                             setDialogState(() => selectedFormat = fmt);
//                           }
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(ctx).pop(),
//                 child: Text(
//                   AppStrings.cancel,
//                   style: TextStyle(
//                     color: isDark
//                         ? const Color(0xFF94A3B8)
//                         : const Color(0xFF6B7280),
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   final text = nameController.text.trim();
//                   if (text.isNotEmpty) {
//                     final filename = text.endsWith('.$selectedFormat')
//                         ? text
//                         : '$text.$selectedFormat';
//                     context.read<DocumentsBloc>().add(
//                           UploadDocumentEvent(
//                             name: filename,
//                             category: selectedCategory,
//                             extension: selectedFormat,
//                             fileSize: '50 KB',
//                             description:
//                                 'Corporate $selectedCategory workspace document.',
//                           ),
//                         );
//                     Navigator.of(ctx).pop();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content:
//                             Text('Document "$filename" uploaded successfully'),
//                         backgroundColor: const Color(0xFFDE5227),
//                         behavior: SnackBarBehavior.floating,
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFDE5227),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: const Text(AppStrings.upload),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void _handleNavigation(int index) {
//       if (index == 2) return; // Already on Documents
//     if (index == 0) {
//       Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
//     } else if (index == 1) {
//       Navigator.of(context).pushReplacementNamed(AppRoutes.messages);
//     } else if (index == 2) {
//       Navigator.of(context).pushReplacementNamed(AppRoutes.documents);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isMobile = size.width < 960;

//     return BlocBuilder<DocumentsBloc, DocumentsState>(
//       builder: (context, state) {
//         final documents = state.filteredDocuments;
//         final selectedDoc = state.selectedDocument;

//         // Auto-select first document on desktop if none selected to match Screenshot 1
//         if (!isMobile &&
//             selectedDoc == null &&
//             documents.isNotEmpty &&
//             state.selectedDocumentId == null) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             context
//                 .read<DocumentsBloc>()
//                 .add(SelectDocumentEvent(documents.first.id));
//           });
//         }

//         return Scaffold(
//           key: _scaffoldKey,
//           backgroundColor:
//               _isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF9FAFB),
//           drawer: isMobile
//               ? Drawer(
//                   child: DashboardSidebar(
//                     selectedIndex: 2, // 2 = Documents
//                     onItemSelected: (idx) {
//                       Navigator.of(context).pop();
//                       _handleNavigation(idx);
//                     },
//                     onSignOut: () {
//                       Navigator.of(context)
//                           .pushReplacementNamed(AppRoutes.login);
//                     },
//                   ),
//                 )
//               : null,
//           bottomNavigationBar: isMobile && selectedDoc == null
//               ? DashboardBottomNav(
//                   selectedIndex: 2, // 2 = Docs active
//                   onIndexChanged: (idx) => _handleNavigation(idx),
//                   isDarkMode: _isDarkMode,
//                 )
//               : null,
//           floatingActionButton: isMobile && selectedDoc == null
//               ? FloatingActionButton(
//                   onPressed: () => _showUploadDialog(context),
//                   backgroundColor: const Color(0xFFDE5227),
//                   foregroundColor: Colors.white,
//                   elevation: 6,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: const Icon(Icons.file_upload_outlined, size: 24),
//                 )
//               : null,
//           body: Row(
//             children: [
//               // Desktop Fixed Sidebar
//               if (!isMobile)
//                 DashboardSidebar(
//                   selectedIndex: 2, // 2 = Documents
//                   onItemSelected: (idx) => _handleNavigation(idx),
//                   onSignOut: () {
//                     Navigator.of(context).pushReplacementNamed(AppRoutes.login);
//                   },
//                 ),

//               // Main Work Area
//               Expanded(
//                 child: Column(
//                   children: [
//                     // Top App Bar matching Screenshot 1 & 2
//                     _buildTopAppBar(context, isMobile),

//                     // Main Content: List & Details Panel
//                     Expanded(
//                       child: isMobile
//                           ? _buildMobileContent(
//                               context, state, documents, selectedDoc)
//                           : _buildDesktopContent(
//                               context, state, documents, selectedDoc),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   /// Top App Bar matching screenshots
//   Widget _buildTopAppBar(BuildContext context, bool isMobile) {
//     return Container(
//       height: 60,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: _isDarkMode ? const Color(0xFF1E293B) : Colors.white,
//         border: Border(
//           bottom: BorderSide(
//             color:
//                 _isDarkMode ? const Color(0x1AFFFFFF) : const Color(0xFFE5E7EB),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Left Sidebar Toggle Icon
//           IconButton(
//             icon: Icon(
//               isMobile ? Icons.menu_rounded : Icons.view_sidebar_outlined,
//               size: 22,
//             ),
//             color: _isDarkMode ? Colors.white : const Color(0xFF1F2937),
//             onPressed: () {
//               if (isMobile) {
//                 _scaffoldKey.currentState?.openDrawer();
//               }
//             },
//           ),
//           const SizedBox(width: 8),

//           // Title
//           Text(
//             AppStrings.documentsScreenTitle,
//             style: TextStyle(
//               color: _isDarkMode ? Colors.white : const Color(0xFF111827),
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               letterSpacing: -0.2,
//             ),
//           ),

//           const Spacer(),

//           // Notification Bell with Badge "398" matching Screenshot
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.notifications_none_rounded, size: 22),
//                 color: _isDarkMode ? Colors.white70 : const Color(0xFF4B5563),
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Notifications (398 unread alerts)'),
//                       behavior: SnackBarBehavior.floating,
//                     ),
//                   );
//                 },
//               ),
//               Positioned(
//                 right: 4,
//                 top: 4,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFDE5227),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Text(
//                     '398',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 9.5,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(width: 4),

//           // Dark Mode Toggle
//           IconButton(
//             icon: Icon(
//               _isDarkMode ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
//               size: 20,
//             ),
//             color: _isDarkMode ? Colors.amber : const Color(0xFF4B5563),
//             onPressed: () {
//               setState(() => _isDarkMode = !_isDarkMode);
//             },
//           ),

//           const SizedBox(width: 8),

//           // Profile Avatar 'SI'
//           Container(
//             width: 36,
//             height: 36,
//             decoration: const BoxDecoration(
//               color: Color(0xFFDE5227),
//               shape: BoxShape.circle,
//             ),
//             alignment: Alignment.center,
//             child: const Text(
//               'SI',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Desktop Layout: Left List Column + Right Details Panel
//   Widget _buildDesktopContent(
//     BuildContext context,
//     DocumentsState state,
//     List<AppDocument> documents,
//     AppDocument? selectedDoc,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Left Column: Document List & Search/Filter (Width: 380px)
//         Container(
//           width: 380,
//           decoration: BoxDecoration(
//             color: _isDarkMode ? const Color(0xFF131D2E) : Colors.white,
//             border: Border(
//               right: BorderSide(
//                 color: _isDarkMode
//                     ? const Color(0x1AFFFFFF)
//                     : const Color(0xFFE5E7EB),
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Header Row: "Documents" title & orange "Upload" button
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       AppStrings.documentsScreenTitle,
//                       style: TextStyle(
//                         color: _isDarkMode
//                             ? Colors.white
//                             : const Color(0xFF111827),
//                         fontSize: 20,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: -0.3,
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: () => _showUploadDialog(context),
//                       icon: const Icon(Icons.file_upload_outlined, size: 17),
//                       label: const Text(
//                         AppStrings.uploadButtonLabel,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 13.5),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFDE5227),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Search field & Category dropdown
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     DocumentSearchField(
//                       controller: _searchController,
//                       isDarkMode: _isDarkMode,
//                       onChanged: (val) {
//                         context
//                             .read<DocumentsBloc>()
//                             .add(SearchDocumentsEvent(val));
//                       },
//                       onClear: () {
//                         context
//                             .read<DocumentsBloc>()
//                             .add(const SearchDocumentsEvent(''));
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     DocumentCategoryDropdown(
//                       categories: state.categories,
//                       selectedCategory: state.selectedCategory,
//                       isDarkMode: _isDarkMode,
//                       onCategoryChanged: (cat) {
//                         context
//                             .read<DocumentsBloc>()
//                             .add(CategoryFilterChangedEvent(cat));
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Document Items List
//               Expanded(
//                 child: state.isLoading
//                     ? const Center(
//                         child:
//                             CircularProgressIndicator(color: Color(0xFFDE5227)),
//                       )
//                     : documents.isEmpty
//                         ? Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(24),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.search_off_rounded,
//                                     size: 44,
//                                     color: _isDarkMode
//                                         ? Colors.white38
//                                         : Colors.black26,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Text(
//                                     'No documents found',
//                                     style: TextStyle(
//                                       color: _isDarkMode
//                                           ? Colors.white70
//                                           : const Color(0xFF374151),
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 14.5,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : ListView.separated(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 14, vertical: 4),
//                             itemCount: documents.length,
//                             separatorBuilder: (ctx, i) =>
//                                 const SizedBox(height: 4),
//                             itemBuilder: (ctx, i) {
//                               final doc = documents[i];
//                               final isSelected = selectedDoc?.id == doc.id;
//                               return DocumentListItem(
//                                 document: doc,
//                                 isSelected: isSelected,
//                                 isDarkMode: _isDarkMode,
//                                 onTap: () {
//                                   context
//                                       .read<DocumentsBloc>()
//                                       .add(SelectDocumentEvent(doc.id));
//                                 },
//                               );
//                             },
//                           ),
//               ),
//             ],
//           ),
//         ),

//         // Right Column: Document Details Panel (or Empty state)
//         Expanded(
//           child: selectedDoc == null
//               ? DocumentEmptyPreview(isDarkMode: _isDarkMode)
//               : DocumentPreviewPanel(
//                   document: selectedDoc,
//                   isDarkMode: _isDarkMode,
//                   isMobile: false,
//                   onClose: () {
//                     context
//                         .read<DocumentsBloc>()
//                         .add(const ClearSelectedDocumentEvent());
//                   },
//                 ),
//         ),
//       ],
//     );
//   }

//   /// Mobile Layout: Document list with FAB or full-screen preview when document tapped
//   Widget _buildMobileContent(
//     BuildContext context,
//     DocumentsState state,
//     List<AppDocument> documents,
//     AppDocument? selectedDoc,
//   ) {
//     if (selectedDoc != null) {
//       return DocumentPreviewPanel(
//         document: selectedDoc,
//         isDarkMode: _isDarkMode,
//         isMobile: true,
//         onClose: () {
//           context.read<DocumentsBloc>().add(const ClearSelectedDocumentEvent());
//         },
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Mobile Header & Upload Row
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 AppStrings.documentsScreenTitle,
//                 style: TextStyle(
//                   color: _isDarkMode ? Colors.white : const Color(0xFF111827),
//                   fontSize: 20,
//                   fontWeight: FontWeight.w800,
//                   letterSpacing: -0.3,
//                 ),
//               ),
//               ElevatedButton.icon(
//                 onPressed: () => _showUploadDialog(context),
//                 icon: const Icon(Icons.file_upload_outlined, size: 16),
//                 label: const Text(
//                   AppStrings.uploadButtonLabel,
//                   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFDE5227),
//                   foregroundColor: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Search & Category Dropdown
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               DocumentSearchField(
//                 controller: _searchController,
//                 isDarkMode: _isDarkMode,
//                 onChanged: (val) {
//                   context.read<DocumentsBloc>().add(SearchDocumentsEvent(val));
//                 },
//                 onClear: () {
//                   context
//                       .read<DocumentsBloc>()
//                       .add(const SearchDocumentsEvent(''));
//                 },
//               ),
//               const SizedBox(height: 10),
//               DocumentCategoryDropdown(
//                 categories: state.categories,
//                 selectedCategory: state.selectedCategory,
//                 isDarkMode: _isDarkMode,
//                 onCategoryChanged: (cat) {
//                   context
//                       .read<DocumentsBloc>()
//                       .add(CategoryFilterChangedEvent(cat));
//                 },
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 12),

//         // Document List
//         Expanded(
//           child: state.isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(color: Color(0xFFDE5227)),
//                 )
//               : ListView.separated(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//                   itemCount: documents.length,
//                   separatorBuilder: (ctx, i) => const SizedBox(height: 4),
//                   itemBuilder: (ctx, i) {
//                     final doc = documents[i];
//                     return DocumentListItem(
//                       document: doc,
//                       isSelected: false,
//                       isDarkMode: _isDarkMode,
//                       onTap: () {
//                         context
//                             .read<DocumentsBloc>()
//                             .add(SelectDocumentEvent(doc.id));
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
//   }
// }

import 'package:apache_connect/presentation/widgets/excel_editor_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/app_document.dart';
import '../bloc/documents/documents_bloc.dart';
import '../bloc/documents/documents_event.dart';
import '../bloc/documents/documents_state.dart';

import '../widgets/document_category_dropdown.dart';
import '../widgets/document_empty_preview.dart';
import '../widgets/document_list_item.dart';
import '../widgets/document_preview_panel.dart';
import '../widgets/document_search_field.dart';
import '../widgets/upload_document_dialog.dart';

class DocumentsScreen extends StatefulWidget {
  final ValueChanged<int>? onNavItemSelected;
  const DocumentsScreen({super.key, this.onNavItemSelected});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final bool _isDarkMode = false;

  bool _isExcelEditing = false;
  String? _editingDocumentId;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<DocumentsBloc>();
    if (bloc.state.status == DocumentsStatus.initial) {
      bloc.add(const LoadDocumentsEvent());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showUploadDialog(BuildContext context) {
    UploadDocumentDialog.show(
      context: context,
      isDarkMode: _isDarkMode,
    );
  }

  // void _showUploadDialog(BuildContext context) {
  //   final nameController = TextEditingController();
  //   String selectedCategory = 'Finance';
  //   String selectedFormat = 'xlsx';
  //   final categories = ['Finance', 'Safety', 'Operations', 'Compliance'];
  //   final formats = ['xlsx', 'docx', 'pptx', 'pdf'];

  //   showDialog(
  //     context: context,
  //     builder: (ctx) => StatefulBuilder(
  //       builder: (ctx, setDialogState) {
  //         final isDark = _isDarkMode;
  //         return AlertDialog(
  //           backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //           title: Text(
  //             AppStrings.uploadDocumentDialogTitle,
  //             style: TextStyle(
  //               color: isDark ? Colors.white : const Color(0xFF1F2937),
  //               fontWeight: FontWeight.w700,
  //               fontSize: 18,
  //             ),
  //           ),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   AppStrings.documentNameLabel,
  //                   style: TextStyle(
  //                     color: isDark
  //                         ? const Color(0xFF94A3B8)
  //                         : const Color(0xFF6B7280),
  //                     fontSize: 12.5,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 6),
  //                 TextField(
  //                   controller: nameController,
  //                   autofocus: true,
  //                   style: TextStyle(
  //                       color: isDark ? Colors.white : const Color(0xFF1F2937)),
  //                   decoration: InputDecoration(
  //                     hintText: 'e.g. Budget-Q4',
  //                     hintStyle: TextStyle(
  //                       color: isDark
  //                           ? const Color(0xFF64748B)
  //                           : const Color(0xFF9CA3AF),
  //                       fontSize: 14,
  //                     ),
  //                     filled: true,
  //                     fillColor: isDark
  //                         ? const Color(0xFF0F172A)
  //                         : const Color(0xFFF9FAFB),
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         horizontal: 14, vertical: 12),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                       borderSide: BorderSide(
  //                         color: isDark
  //                             ? const Color(0x22FFFFFF)
  //                             : const Color(0xFFE5E7EB),
  //                       ),
  //                     ),
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                       borderSide: BorderSide(
  //                         color: isDark
  //                             ? const Color(0x22FFFFFF)
  //                             : const Color(0xFFE5E7EB),
  //                       ),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                       borderSide: const BorderSide(color: Color(0xFFDE5227)),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   AppStrings.categoryDropdownLabel,
  //                   style: TextStyle(
  //                     color: isDark
  //                         ? const Color(0xFF94A3B8)
  //                         : const Color(0xFF6B7280),
  //                     fontSize: 12.5,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 6),
  //                 Container(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12),
  //                   decoration: BoxDecoration(
  //                     color: isDark
  //                         ? const Color(0xFF0F172A)
  //                         : const Color(0xFFF9FAFB),
  //                     borderRadius: BorderRadius.circular(10),
  //                     border: Border.all(
  //                       color: isDark
  //                           ? const Color(0x22FFFFFF)
  //                           : const Color(0xFFE5E7EB),
  //                     ),
  //                   ),
  //                   child: DropdownButtonHideUnderline(
  //                     child: DropdownButton<String>(
  //                       value: selectedCategory,
  //                       isExpanded: true,
  //                       dropdownColor:
  //                           isDark ? const Color(0xFF1E293B) : Colors.white,
  //                       style: TextStyle(
  //                         color:
  //                             isDark ? Colors.white : const Color(0xFF1F2937),
  //                         fontSize: 14,
  //                       ),
  //                       items: categories.map((c) {
  //                         return DropdownMenuItem<String>(
  //                             value: c, child: Text(c));
  //                       }).toList(),
  //                       onChanged: (val) {
  //                         if (val != null) {
  //                           setDialogState(() => selectedCategory = val);
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   AppStrings.fileTypeLabel,
  //                   style: TextStyle(
  //                     color: isDark
  //                         ? const Color(0xFF94A3B8)
  //                         : const Color(0xFF6B7280),
  //                     fontSize: 12.5,
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Wrap(
  //                   spacing: 8,
  //                   children: formats.map((fmt) {
  //                     final isSelected = selectedFormat == fmt;
  //                     return ChoiceChip(
  //                       label: Text(fmt.toUpperCase()),
  //                       selected: isSelected,
  //                       selectedColor: const Color(0xFFDE5227),
  //                       labelStyle: TextStyle(
  //                         color: isSelected
  //                             ? Colors.white
  //                             : (isDark
  //                                 ? Colors.white70
  //                                 : const Color(0xFF374151)),
  //                         fontWeight: FontWeight.w700,
  //                         fontSize: 12,
  //                       ),
  //                       backgroundColor: isDark
  //                           ? const Color(0xFF0F172A)
  //                           : const Color(0xFFF3F4F6),
  //                       onSelected: (sel) {
  //                         if (sel) {
  //                           setDialogState(() => selectedFormat = fmt);
  //                         }
  //                       },
  //                     );
  //                   }).toList(),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(ctx).pop(),
  //               child: Text(
  //                 AppStrings.cancel,
  //                 style: TextStyle(
  //                   color: isDark
  //                       ? const Color(0xFF94A3B8)
  //                       : const Color(0xFF6B7280),
  //                 ),
  //               ),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 final text = nameController.text.trim();
  //                 if (text.isNotEmpty) {
  //                   final filename = text.endsWith('.$selectedFormat')
  //                       ? text
  //                       : '$text.$selectedFormat';
  //                   context.read<DocumentsBloc>().add(
  //                         UploadDocumentEvent(
  //                           name: filename,
  //                           category: selectedCategory,
  //                           extension: selectedFormat,
  //                           fileSize: '50 KB',
  //                           description:
  //                               'Corporate $selectedCategory workspace document.',
  //                         ),
  //                       );
  //                   Navigator.of(ctx).pop();
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content:
  //                           Text('Document "$filename" uploaded successfully'),
  //                       backgroundColor: const Color(0xFFDE5227),
  //                       behavior: SnackBarBehavior.floating,
  //                     ),
  //                   );
  //                 }
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color(0xFFDE5227),
  //                 foregroundColor: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10)),
  //               ),
  //               child: const Text(AppStrings.upload),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  // void _handleNavigation(int index) {
  //   if (index == 0) {
  //     Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
  //   } else if (index == 1) {
  //     Navigator.of(context).pushReplacementNamed(AppRoutes.messages);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 960;

    return BlocBuilder<DocumentsBloc, DocumentsState>(
      builder: (context, state) {
        final documents = state.filteredDocuments;
        final selectedDoc = state.selectedDocument;
        // final loginState = context.read<LoginBloc>().state;
        // final user = loginState.authenticatedUser;

        // Auto-select first document on desktop if none selected to match Screenshot 1
        if (!isMobile &&
            selectedDoc == null &&
            documents.isNotEmpty &&
            state.selectedDocumentId == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context
                .read<DocumentsBloc>()
                .add(SelectDocumentEvent(documents.first.id));
          });
        }

        // return AppScaffold(
        //   title: AppStrings.documentsScreenTitle,
        //   activeNavIndex: 2,
        //   isDarkMode: _isDarkMode,
        //   employeeName:
        //       user?.displayName ?? user?.username ?? 'Unknown Employee',
        //   employeeNo: user?.id ?? 'Unknown ID',
        //   onThemeToggle: () {
        //     setState(() => _isDarkMode = !_isDarkMode);
        //   },
        //   onNotificationPressed: () {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text('Notifications (6 unread)'),
        //         behavior: SnackBarBehavior.floating,
        //       ),
        //     );
        //   },
        //   onProfilePressed: () {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       const SnackBar(
        //         content: Text('Logged in as Syed Imran (Admin)'),
        //         behavior: SnackBarBehavior.floating,
        //       ),
        //     );
        //   },
        //   // onNavItemSelected: _handleNavigation,
        //   onNavItemSelected: widget.onNavItemSelected,
        //   floatingActionButton: isMobile && selectedDoc == null
        //       ? FloatingActionButton(
        //           // heroTag: 'documentsUploadFab',
        //           heroTag: null,
        //           onPressed: () => _showUploadDialog(context),
        //           backgroundColor: const Color(0xFFDE5227),
        //           foregroundColor: Colors.white,
        //           elevation: 6,
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(16)),
        //           child: const Icon(Icons.file_upload_outlined, size: 24),
        //         )
        //       : null,
        //   body: isMobile
        //       ? _buildMobileContent(context, state, documents, selectedDoc)
        //       : _buildDesktopContent(context, state, documents, selectedDoc),
        // );
        return Stack(
          children: [
            Positioned.fill(
              child: isMobile
                  ? _buildMobileContent(context, state, documents, selectedDoc)
                  : _buildDesktopContent(
                      context, state, documents, selectedDoc),
            ),
            if (isMobile && selectedDoc == null)
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  heroTag: 'documentsUploadFab',
                  onPressed: () => _showUploadDialog(context),
                  backgroundColor: const Color(0xFFDE5227),
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.file_upload_outlined, size: 24),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Desktop Layout: Left List Column + Right Details Panel
  Widget _buildDesktopContent(
    BuildContext context,
    DocumentsState state,
    List<AppDocument> documents,
    AppDocument? selectedDoc,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left Column: Document List & Search/Filter (Width: 380px)
        Container(
          width: 380,
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF131D2E) : Colors.white,
            border: Border(
              right: BorderSide(
                color: _isDarkMode
                    ? const Color(0x1AFFFFFF)
                    : const Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Row: "Documents" title & orange "Upload" button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.documentsScreenTitle,
                      style: TextStyle(
                        color: _isDarkMode
                            ? Colors.white
                            : const Color(0xFF111827),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showUploadDialog(context),
                      icon: const Icon(Icons.file_upload_outlined, size: 17),
                      label: const Text(
                        AppStrings.uploadButtonLabel,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13.5),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDE5227),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search field & Category dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    DocumentSearchField(
                      controller: _searchController,
                      isDarkMode: _isDarkMode,
                      onChanged: (val) {
                        context
                            .read<DocumentsBloc>()
                            .add(SearchDocumentsEvent(val));
                      },
                      onClear: () {
                        context
                            .read<DocumentsBloc>()
                            .add(const SearchDocumentsEvent(''));
                      },
                    ),
                    const SizedBox(height: 12),
                    DocumentCategoryDropdown(
                      categories: state.categories,
                      selectedCategory: state.selectedCategory,
                      isDarkMode: _isDarkMode,
                      onCategoryChanged: (cat) {
                        context
                            .read<DocumentsBloc>()
                            .add(CategoryFilterChangedEvent(cat));
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Document Items List
              Expanded(
                child: state.isLoading
                    ? const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xFFDE5227)),
                      )
                    : documents.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 44,
                                    color: _isDarkMode
                                        ? Colors.white38
                                        : Colors.black26,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'No documents found',
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? Colors.white70
                                          : const Color(0xFF374151),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 4),
                            itemCount: documents.length,
                            separatorBuilder: (ctx, i) =>
                                const SizedBox(height: 4),
                            itemBuilder: (ctx, i) {
                              final doc = documents[i];
                              final isSelected = selectedDoc?.id == doc.id;
                              return DocumentListItem(
                                document: doc,
                                isSelected: isSelected,
                                isDarkMode: _isDarkMode,
                                onTap: () {
                                  context
                                      .read<DocumentsBloc>()
                                      .add(SelectDocumentEvent(doc.id));
                                },
                                onDoubleTap: () {
                                  final extension = doc.extension.toLowerCase();

                                  if (extension == 'xlsx' ||
                                      extension == 'xls') {
                                    setState(() {
                                      _isExcelEditing = true;
                                      _editingDocumentId = doc.id;
                                    });
                                  }
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),

        // Right Column: Document Details Panel (or Empty state)
        // Expanded(
        //   child: selectedDoc == null
        //       ? DocumentEmptyPreview(isDarkMode: _isDarkMode)
        //       : DocumentPreviewPanel(
        //           document: selectedDoc,
        //           isDarkMode: _isDarkMode,
        //           isMobile: false,
        //           onClose: () {
        //             context
        //                 .read<DocumentsBloc>()
        //                 .add(const ClearSelectedDocumentEvent());
        //           },
        //         ),
        // ),

        Expanded(
          child: _isExcelEditing &&
                  selectedDoc != null &&
                  selectedDoc.id == _editingDocumentId
              ?
              // ExcelEditorPanel(
              //     documentName: selectedDoc.name,
              //     onClose: () {
              //       setState(() {
              //         _isExcelEditing = false;
              //         _editingDocumentId = null;
              //       });
              //     }, fileBytes: null,
              //   )
              ExcelEditorPanel(
                  documentName: selectedDoc.name,
                  fileBytes: state.fileBytesByDocumentId[selectedDoc.id],
                  onClose: () {
                    setState(() {
                      _isExcelEditing = false;
                      _editingDocumentId = null;
                    });
                  },
                )
              : selectedDoc == null
                  ? DocumentEmptyPreview(
                      isDarkMode: _isDarkMode,
                    )
                  : DocumentPreviewPanel(
                      document: selectedDoc,
                      isDarkMode: _isDarkMode,
                      isMobile: false,
                      onClose: () {
                        context.read<DocumentsBloc>().add(
                              const ClearSelectedDocumentEvent(),
                            );
                      },
                    ),
        ),
      ],
    );
  }

  /// Mobile Layout: Document list with FAB or full-screen preview when document tapped
  Widget _buildMobileContent(
    BuildContext context,
    DocumentsState state,
    List<AppDocument> documents,
    AppDocument? selectedDoc,
  ) {
    // if (selectedDoc != null) {
    //   return DocumentPreviewPanel(
    //     document: selectedDoc,
    //     isDarkMode: _isDarkMode,
    //     isMobile: true,
    //     onClose: () {
    //       context.read<DocumentsBloc>().add(const ClearSelectedDocumentEvent());
    //     },
    //   );
    // }

    if (selectedDoc != null) {
      // Show Excel editor when an Excel document is opened.
      if (_isExcelEditing &&
          selectedDoc.id == _editingDocumentId &&
          (selectedDoc.extension.toLowerCase() == 'xlsx' ||
              selectedDoc.extension.toLowerCase() == 'xls')) {
        return ExcelEditorPanel(
          documentName: selectedDoc.name,
          fileBytes: state.fileBytesByDocumentId[selectedDoc.id],
          onClose: () {
            setState(() {
              _isExcelEditing = false;
              _editingDocumentId = null;
            });
          },
        );
      }

      // Show the normal preview for other documents.
      return DocumentPreviewPanel(
        document: selectedDoc,
        isDarkMode: _isDarkMode,
        isMobile: true,
        onClose: () {
          setState(() {
            _isExcelEditing = false;
            _editingDocumentId = null;
          });

          context.read<DocumentsBloc>().add(
                const ClearSelectedDocumentEvent(),
              );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mobile Header & Upload Row
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.documentsScreenTitle,
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : const Color(0xFF111827),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showUploadDialog(context),
                icon: const Icon(Icons.file_upload_outlined, size: 16),
                label: const Text(
                  AppStrings.uploadButtonLabel,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDE5227),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Search & Category Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              DocumentSearchField(
                controller: _searchController,
                isDarkMode: _isDarkMode,
                onChanged: (val) {
                  context.read<DocumentsBloc>().add(SearchDocumentsEvent(val));
                },
                onClear: () {
                  context
                      .read<DocumentsBloc>()
                      .add(const SearchDocumentsEvent(''));
                },
              ),
              const SizedBox(height: 10),
              DocumentCategoryDropdown(
                categories: state.categories,
                selectedCategory: state.selectedCategory,
                isDarkMode: _isDarkMode,
                onCategoryChanged: (cat) {
                  context
                      .read<DocumentsBloc>()
                      .add(CategoryFilterChangedEvent(cat));
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Document List
        Expanded(
          child: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFDE5227)),
                )
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  itemCount: documents.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 4),
                  itemBuilder: (ctx, i) {
                    final doc = documents[i];
                    // return DocumentListItem(
                    //   document: doc,
                    //   isSelected: false,
                    //   isDarkMode: _isDarkMode,
                    //   onTap: () {
                    //     context
                    //         .read<DocumentsBloc>()
                    //         .add(SelectDocumentEvent(doc.id));
                    //   },
                    //   onDoubleTap: () {
                    //     final extension = doc.extension.toLowerCase();

                    //     if (extension == 'xlsx' || extension == 'xls') {
                    //       setState(() {
                    //         _isExcelEditing = true;
                    //         _editingDocumentId = doc.id;
                    //       });
                    //     }
                    //   },
                    // );

                    return DocumentListItem(
                      document: doc,
                      isSelected: selectedDoc?.id == doc.id,
                      isDarkMode: _isDarkMode,
                      onTap: () {
                        final extension = doc.extension.toLowerCase();

                        if (extension == 'xlsx' || extension == 'xls') {
                          setState(() {
                            _isExcelEditing = true;
                            _editingDocumentId = doc.id;
                          });
                        } else {
                          setState(() {
                            _isExcelEditing = false;
                            _editingDocumentId = null;
                          });
                        }

                        context.read<DocumentsBloc>().add(
                              SelectDocumentEvent(doc.id),
                            );
                      },
                      onDoubleTap: () {
                        final extension = doc.extension.toLowerCase();

                        if (extension == 'xlsx' || extension == 'xls') {
                          setState(() {
                            _isExcelEditing = true;
                            _editingDocumentId = doc.id;
                          });

                          context.read<DocumentsBloc>().add(
                                SelectDocumentEvent(doc.id),
                              );
                        }
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
