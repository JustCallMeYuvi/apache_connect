import '../models/app_document_model.dart';

abstract class DocumentsRemoteDataSource {
  Future<List<AppDocumentModel>> fetchDocuments();
  Future<AppDocumentModel> uploadDocument({
    required String name,
    required String category,
    required String extension,
    required String fileSize,
    String? description,
  });
  Future<List<String>> fetchCategories();
}

class DocumentsRemoteDataSourceImpl implements DocumentsRemoteDataSource {
  List<AppDocumentModel> _cachedDocuments = [];

  DocumentsRemoteDataSourceImpl() {
    _initInitialDocuments();
  }

  void _initInitialDocuments() {
    _cachedDocuments = [
      const AppDocumentModel(
        id: 'doc_budget_q3',
        name: 'Budget-Q3.xlsx',
        category: 'Finance',
        extension: 'xlsx',
        version: 'V1.1',
        date: 'Sep 18',
        fileSize: '50 KB',
        owner: 'Meena Rao',
        modifiedBy: 'Anita Sharma',
        modifiedDate: 'Sep 18, 2026, 11:17 AM',
        access: 'View · Download · Update · Delete · Comment · Share',
        description: 'Quarterly budget plan',
        commentsCount: 101,
        versionsCount: 2,
      ),
      const AppDocumentModel(
        id: 'doc_safety_plan',
        name: 'Safety-Plan.docx',
        category: 'Safety',
        extension: 'docx',
        version: 'V1.0',
        date: 'Jul 10',
        fileSize: '1.2 MB',
        owner: 'Safety Committee',
        modifiedBy: 'Ravi Kumar',
        modifiedDate: 'Jul 10, 2026, 03:45 PM',
        access: 'View · Download · Update · Comment · Share',
        description: 'Plant safety protocols and emergency escalation guidelines.',
        commentsCount: 42,
        versionsCount: 1,
      ),
      const AppDocumentModel(
        id: 'doc_ops_review',
        name: 'Ops-Review.pptx',
        category: 'Operations',
        extension: 'pptx',
        version: 'V1.0',
        date: 'Sep 30',
        fileSize: '14.5 MB',
        owner: 'Operations Lead',
        modifiedBy: 'Syed Imran',
        modifiedDate: 'Sep 30, 2026, 09:20 AM',
        access: 'View · Download · Update · Delete · Comment · Share',
        description: 'Quarterly manufacturing review and factory throughput benchmarks.',
        commentsCount: 18,
        versionsCount: 3,
      ),
    ];
  }

  @override
  Future<List<AppDocumentModel>> fetchDocuments() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return List.from(_cachedDocuments);
  }

  @override
  Future<AppDocumentModel> uploadDocument({
    required String name,
    required String category,
    required String extension,
    required String fileSize,
    String? description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final cleanExt = extension.toLowerCase().replaceAll('.', '');
    final newDoc = AppDocumentModel(
      id: 'doc_${DateTime.now().millisecondsSinceEpoch}',
      name: name.endsWith('.$cleanExt') ? name : '$name.$cleanExt',
      category: category,
      extension: cleanExt,
      version: 'V1.0',
      date: 'Just now',
      fileSize: fileSize.isNotEmpty ? fileSize : '50 KB',
      owner: 'Syed Imran',
      modifiedBy: 'Syed Imran',
      modifiedDate: 'Oct 12, 2026, 10:00 AM',
      access: 'View · Download · Update · Delete · Comment · Share',
      description: description ?? 'Quarterly workspace document',
      commentsCount: 0,
      versionsCount: 1,
    );
    _cachedDocuments.insert(0, newDoc);
    return newDoc;
  }

  @override
  Future<List<String>> fetchCategories() async {
    return [
      'All categories',
      'Finance',
      'Safety',
      'Operations',
      'Compliance',
    ];
  }
}
