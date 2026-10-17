import 'package:flutter/foundation.dart';

class PickedDocumentFile {
  final String name;
  final String extension;
  final int sizeInBytes;
  final String formattedSize;
  final Uint8List? bytes;

  const PickedDocumentFile({
    required this.name,
    required this.extension,
    required this.sizeInBytes,
    required this.formattedSize,
    this.bytes,
  });
}

class FileValidationResult {
  final bool isValid;
  final String? errorMessage;
  final PickedDocumentFile? file;

  const FileValidationResult({
    required this.isValid,
    this.errorMessage,
    this.file,
  });

  factory FileValidationResult.success(PickedDocumentFile file) {
    return FileValidationResult(isValid: true, file: file);
  }

  factory FileValidationResult.error(String message) {
    return FileValidationResult(isValid: false, errorMessage: message);
  }
}

/// Cross-platform document file picker and validator
class DocumentFilePickerService {
  static const int maxFileSizeBytes = 5 * 1024 * 1024; // 5 MB
  static const List<String> allowedExtensions = [
    'pdf',
    'doc',
    'docx',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt',
    'csv',
    'png',
    'jpg',
    'jpeg',
  ];

  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Validates a file's format and size
  static FileValidationResult validateFile({
    required String fileName,
    required int sizeInBytes,
    Uint8List? bytes,
  }) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == fileName.length - 1) {
      return FileValidationResult.error(
        'File must have a valid extension. Allowed: ${allowedExtensions.join(', ')}',
      );
    }

    final ext = fileName.substring(dotIndex + 1).toLowerCase();

    if (!allowedExtensions.contains(ext)) {
      return FileValidationResult.error(
        'Unsupported file format ".$ext". Allowed: ${allowedExtensions.join(', ')}',
      );
    }

    if (sizeInBytes > maxFileSizeBytes) {
      return FileValidationResult.error(
        'File exceeds maximum size of 5 MB (${formatBytes(sizeInBytes)}).',
      );
    }

    return FileValidationResult.success(
      PickedDocumentFile(
        name: fileName,
        extension: ext,
        sizeInBytes: sizeInBytes,
        formattedSize: formatBytes(sizeInBytes),
        bytes: bytes,
      ),
    );
  }

  /// Preset / Sample files for quick and reliable cross-platform demo and testing
  static List<PickedDocumentFile> getSampleFiles() {
    return [
      const PickedDocumentFile(
        name: 'Gnxtace Technologies - Flutter Developer Assessment.pdf',
        extension: 'pdf',
        sizeInBytes: 588 * 1024,
        formattedSize: '588 KB',
      ),
      const PickedDocumentFile(
        name: 'Budget-Q4-Forecast.xlsx',
        extension: 'xlsx',
        sizeInBytes: 245 * 1024,
        formattedSize: '245 KB',
      ),
      const PickedDocumentFile(
        name: 'Safety-Protocols-2026.docx',
        extension: 'docx',
        sizeInBytes: 1024 * 1024,
        formattedSize: '1.0 MB',
      ),
      const PickedDocumentFile(
        name: 'Factory-Equipment-Log.csv',
        extension: 'csv',
        sizeInBytes: 86 * 1024,
        formattedSize: '86 KB',
      ),
    ];
  }
}
