
import 'package:equatable/equatable.dart';

abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDocumentsEvent extends DocumentsEvent {
  const LoadDocumentsEvent();
}

class SearchDocumentsEvent extends DocumentsEvent {
  final String query;
  const SearchDocumentsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class CategoryFilterChangedEvent extends DocumentsEvent {
  final String category;
  const CategoryFilterChangedEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class SelectDocumentEvent extends DocumentsEvent {
  final String documentId;
  const SelectDocumentEvent(this.documentId);

  @override
  List<Object?> get props => [documentId];
}

class ClearSelectedDocumentEvent extends DocumentsEvent {
  const ClearSelectedDocumentEvent();
}

class UploadDocumentEvent extends DocumentsEvent {
  final String name;
  final String category;
  final String extension;
  final String fileSize;
  final String? description;

  const UploadDocumentEvent({
    required this.name,
    required this.category,
    required this.extension,
    this.fileSize = '2.4 MB',
    this.description,
  });

  @override
  List<Object?> get props => [name, category, extension, fileSize, description];
}
