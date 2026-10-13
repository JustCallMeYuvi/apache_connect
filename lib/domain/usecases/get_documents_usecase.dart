import '../../core/network/api_result.dart';
import '../entities/app_document.dart';
import '../repositories/documents_repository.dart';

class GetDocumentsUseCase {
  final DocumentsRepository _repository;

  GetDocumentsUseCase(this._repository);

  Future<ApiResult<List<AppDocument>>> execute() async {
    return await _repository.getDocuments();
  }
}
