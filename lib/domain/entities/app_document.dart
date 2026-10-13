import 'package:equatable/equatable.dart';

class AppDocument extends Equatable {
  final String id;
  final String name;
  final String category;
  final String extension; // 'xlsx', 'docx', 'pptx', 'pdf'
  final String version;
  final String date;
  final String fileSize;
  final String owner;
  final String modifiedBy;
  final String modifiedDate;
  final String access;
  final String description;
  final int commentsCount;
  final int versionsCount;

  const AppDocument({
    required this.id,
    required this.name,
    required this.category,
    required this.extension,
    required this.version,
    required this.date,
    this.fileSize = '50 KB',
    this.owner = 'Meena Rao',
    this.modifiedBy = 'Anita Sharma',
    this.modifiedDate = 'Sep 18, 2026, 11:17 AM',
    this.access = 'View · Download · Update · Delete · Comment · Share',
    this.description = 'Quarterly budget plan',
    this.commentsCount = 101,
    this.versionsCount = 2,
  });

  AppDocument copyWith({
    String? id,
    String? name,
    String? category,
    String? extension,
    String? version,
    String? date,
    String? fileSize,
    String? owner,
    String? modifiedBy,
    String? modifiedDate,
    String? access,
    String? description,
    int? commentsCount,
    int? versionsCount,
  }) {
    return AppDocument(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      extension: extension ?? this.extension,
      version: version ?? this.version,
      date: date ?? this.date,
      fileSize: fileSize ?? this.fileSize,
      owner: owner ?? this.owner,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      access: access ?? this.access,
      description: description ?? this.description,
      commentsCount: commentsCount ?? this.commentsCount,
      versionsCount: versionsCount ?? this.versionsCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        extension,
        version,
        date,
        fileSize,
        owner,
        modifiedBy,
        modifiedDate,
        access,
        description,
        commentsCount,
        versionsCount,
      ];
}
