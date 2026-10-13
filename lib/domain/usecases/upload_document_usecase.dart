import '../../core/network/api_result.dart';
import '../entities/app_document.dart';
import '../repositories/documents_repository.dart';

class UploadDocumentUseCase {
  final DocumentsRepository _repository;

  UploadDocumentUseCase(this._repository);

  Future<ApiResult<AppDocument>> execute({
    required String name,
    required String category,
    required String extension,
    required String fileSize,
    String? description,
  }) async {
    return await _repository.uploadDocument(
      name: name,
      category: category,
      extension: extension,
      fileSize: fileSize,
      description: description,
    );
  }
}
