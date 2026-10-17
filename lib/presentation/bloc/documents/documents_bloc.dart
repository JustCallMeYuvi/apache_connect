import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_result.dart';
import '../../../domain/entities/app_document.dart';
import '../../../domain/usecases/get_documents_usecase.dart';
import '../../../domain/usecases/upload_document_usecase.dart';
import 'documents_event.dart';
import 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final GetDocumentsUseCase _getDocumentsUseCase;
  final UploadDocumentUseCase _uploadDocumentUseCase;

  DocumentsBloc({
    required GetDocumentsUseCase getDocumentsUseCase,
    required UploadDocumentUseCase uploadDocumentUseCase,
  })  : _getDocumentsUseCase = getDocumentsUseCase,
        _uploadDocumentUseCase = uploadDocumentUseCase,
        super(const DocumentsState()) {
    on<LoadDocumentsEvent>(_onLoadDocuments);
    on<SearchDocumentsEvent>(_onSearchDocuments);
    on<CategoryFilterChangedEvent>(_onCategoryFilterChanged);
    on<SelectDocumentEvent>(_onSelectDocument);
    on<ClearSelectedDocumentEvent>(_onClearSelectedDocument);
    on<UploadDocumentEvent>(_onUploadDocument);
  }

  Future<void> _onLoadDocuments(
    LoadDocumentsEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(state.copyWith(status: DocumentsStatus.loading));

    final result = await _getDocumentsUseCase.execute();

    if (result is Success<List<AppDocument>>) {
      final documents = result.data;
      final categorySet = {'All categories', ...documents.map((d) => d.category)};

      final filtered = _applyFilterAndSearch(
        documents: documents,
        category: state.selectedCategory,
        query: state.searchQuery,
      );

      emit(state.copyWith(
        status: DocumentsStatus.success,
        allDocuments: documents,
        filteredDocuments: filtered,
        categories: categorySet.toList(),
      ));
    } else if (result is Failure<List<AppDocument>>) {
      emit(state.copyWith(
        status: DocumentsStatus.failure,
        errorMessage: result.errorMessage,
      ));
    }
  }

  void _onSearchDocuments(
    SearchDocumentsEvent event,
    Emitter<DocumentsState> emit,
  ) {
    final filtered = _applyFilterAndSearch(
      documents: state.allDocuments,
      category: state.selectedCategory,
      query: event.query,
    );

    emit(state.copyWith(
      searchQuery: event.query,
      filteredDocuments: filtered,
    ));
  }

  void _onCategoryFilterChanged(
    CategoryFilterChangedEvent event,
    Emitter<DocumentsState> emit,
  ) {
    final filtered = _applyFilterAndSearch(
      documents: state.allDocuments,
      category: event.category,
      query: state.searchQuery,
    );

    emit(state.copyWith(
      selectedCategory: event.category,
      filteredDocuments: filtered,
    ));
  }

  void _onSelectDocument(
    SelectDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) {
    emit(state.copyWith(selectedDocumentId: event.documentId));
  }

  void _onClearSelectedDocument(
    ClearSelectedDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) {
    emit(state.copyWith(clearSelected: true));
  }

  Future<void> _onUploadDocument(
    UploadDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(state.copyWith(isUploading: true));

    final result = await _uploadDocumentUseCase.execute(
      name: event.name,
      category: event.category,
      extension: event.extension,
      fileSize: event.fileSize,
      description: event.description,
    );

    if (result is Success<AppDocument>) {
      final updatedList = List<AppDocument>.from(state.allDocuments)..insert(0, result.data);
      final categorySet = {'All categories', ...updatedList.map((d) => d.category)};
      final updatedFileBytes = Map<String, Uint8List>.from(
  state.fileBytesByDocumentId,
);
      updatedFileBytes[result.data.id] = event.bytes;

      final filtered = _applyFilterAndSearch(
        documents: updatedList,
        category: state.selectedCategory,
        query: state.searchQuery,
      );

      emit(state.copyWith(
        isUploading: false,
        allDocuments: updatedList,
        filteredDocuments: filtered,
        categories: categorySet.toList(),
        selectedDocumentId: result.data.id,
        fileBytesByDocumentId: updatedFileBytes,
      ));
    } else if (result is Failure<AppDocument>) {
      emit(state.copyWith(
        isUploading: false,
        errorMessage: result.errorMessage,
      ));
    }
  }

  List<AppDocument> _applyFilterAndSearch({
    required List<AppDocument> documents,
    required String category,
    required String query,
  }) {
    var result = documents;

    if (category != 'All categories' && category.isNotEmpty) {
      result = result.where((d) => d.category.toLowerCase() == category.toLowerCase()).toList();
    }

    if (query.trim().isNotEmpty) {
      final q = query.toLowerCase().trim();
      result = result.where((d) {
        return d.name.toLowerCase().contains(q) ||
            d.category.toLowerCase().contains(q) ||
            d.extension.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }
}
