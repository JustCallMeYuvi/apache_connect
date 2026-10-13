import '../../core/network/api_result.dart';
import '../entities/app_document.dart';

abstract class DocumentsRepository {
  Future<ApiResult<List<AppDocument>>> getDocuments();

  Future<ApiResult<AppDocument>> uploadDocument({
    required String name,
    required String category,
    required String extension,
    required String fileSize,
    String? description,
  });

  Future<ApiResult<List<String>>> getCategories();
}
