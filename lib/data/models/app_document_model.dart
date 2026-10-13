import '../../domain/entities/app_document.dart';

class AppDocumentModel extends AppDocument {
  const AppDocumentModel({
    required super.id,
    required super.name,
    required super.category,
    required super.extension,
    required super.version,
    required super.date,
    super.fileSize,
    super.owner,
    super.modifiedBy,
    super.modifiedDate,
    super.access,
    super.description,
    super.commentsCount,
    super.versionsCount,
  });

  factory AppDocumentModel.fromJson(Map<String, dynamic> json) {
    return AppDocumentModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      extension: json['extension'] as String? ?? 'docx',
      version: json['version'] as String? ?? 'V1.0',
      date: json['date'] as String? ?? '',
      fileSize: json['file_size'] as String? ?? '50 KB',
      owner: json['owner'] as String? ?? 'Meena Rao',
      modifiedBy: json['modified_by'] as String? ?? 'Anita Sharma',
      modifiedDate: json['modified_date'] as String? ?? 'Sep 18, 2026, 11:17 AM',
      access: json['access'] as String? ??
          'View · Download · Update · Delete · Comment · Share',
      description: json['description'] as String? ?? 'Quarterly budget plan',
      commentsCount: json['comments_count'] as int? ?? 101,
      versionsCount: json['versions_count'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'extension': extension,
      'version': version,
      'date': date,
      'file_size': fileSize,
      'owner': owner,
      'modified_by': modifiedBy,
      'modified_date': modifiedDate,
      'access': access,
      'description': description,
      'comments_count': commentsCount,
      'versions_count': versionsCount,
    };
  }
}
