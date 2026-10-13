import '../../core/network/api_result.dart';
import '../../domain/entities/app_document.dart';
import '../../domain/repositories/documents_repository.dart';
import '../datasources/documents_remote_data_source.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  final DocumentsRemoteDataSource remoteDataSource;

  DocumentsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<AppDocument>>> getDocuments() async {
    try {
      final documents = await remoteDataSource.fetchDocuments();
      return Success(documents);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<ApiResult<AppDocument>> uploadDocument({
    required String name,
    required String category,
    required String extension,
    required String fileSize,
    String? description,
  }) async {
    try {
      final doc = await remoteDataSource.uploadDocument(
        name: name,
        category: category,
        extension: extension,
        fileSize: fileSize,
        description: description,
      );
      return Success(doc);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<ApiResult<List<String>>> getCategories() async {
    try {
      final categories = await remoteDataSource.fetchCategories();
      return Success(categories);
    } catch (e) {
      return Failure(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
