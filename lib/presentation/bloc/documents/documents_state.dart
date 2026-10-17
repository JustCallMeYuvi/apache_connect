import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import '../../../domain/entities/app_document.dart';

enum DocumentsStatus { initial, loading, success, failure }

class DocumentsState extends Equatable {
  final DocumentsStatus status;
  final List<AppDocument> allDocuments;
  final List<AppDocument> filteredDocuments;
  final List<String> categories;
  final String selectedCategory;
  final String searchQuery;
  final String? selectedDocumentId;
  final String? errorMessage;
  final bool isUploading;
  final Map<String, Uint8List> fileBytesByDocumentId;

  const DocumentsState({
    this.status = DocumentsStatus.initial,
    this.allDocuments = const [],
    this.filteredDocuments = const [],
    this.categories = const ['All categories'],
    this.selectedCategory = 'All categories',
    this.searchQuery = '',
    this.selectedDocumentId,
    this.errorMessage,
    this.isUploading = false,
    this.fileBytesByDocumentId = const {},
  });

  bool get isLoading => status == DocumentsStatus.loading;
  bool get isSuccess => status == DocumentsStatus.success;
  bool get isFailure => status == DocumentsStatus.failure;

  AppDocument? get selectedDocument {
    if (selectedDocumentId == null) return null;
    try {
      return allDocuments.firstWhere((d) => d.id == selectedDocumentId);
    } catch (_) {
      return null;
    }
  }

  DocumentsState copyWith({
    DocumentsStatus? status,
    List<AppDocument>? allDocuments,
    List<AppDocument>? filteredDocuments,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    String? selectedDocumentId,
    bool clearSelected = false,
    String? errorMessage,
    bool? isUploading,
    Map<String, Uint8List>? fileBytesByDocumentId,
  }) {
    return DocumentsState(
      status: status ?? this.status,
      allDocuments: allDocuments ?? this.allDocuments,
      filteredDocuments: filteredDocuments ?? this.filteredDocuments,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedDocumentId: clearSelected
          ? null
          : (selectedDocumentId ?? this.selectedDocumentId),
      errorMessage: errorMessage ?? this.errorMessage,
      isUploading: isUploading ?? this.isUploading,
      fileBytesByDocumentId:
    fileBytesByDocumentId ?? this.fileBytesByDocumentId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allDocuments,
        filteredDocuments,
        categories,
        selectedCategory,
        searchQuery,
        selectedDocumentId,
        errorMessage,
        isUploading,
        fileBytesByDocumentId,
      ];
}
