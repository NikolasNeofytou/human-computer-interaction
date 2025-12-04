import 'package:flutter/foundation.dart';

/// Enhanced message model supporting text, voice, and file attachments
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.author,
    required this.timestamp,
    required this.isMe,
    required this.type,
    this.text,
    this.voicePath,
    this.voiceDuration,
    this.filePath,
    this.fileName,
    this.fileSize,
    this.fileType,
    this.fileReferences = const [],
  });

  final String id;
  final String author;
  final DateTime timestamp;
  final bool isMe;
  final MessageType type;

  // Text message fields
  final String? text;

  // Voice message fields
  final String? voicePath;
  final Duration? voiceDuration;

  // File attachment fields
  final String? filePath;
  final String? fileName;
  final int? fileSize;
  final FileAttachmentType? fileType;

  // File references (links to project files)
  final List<FileReference> fileReferences;

  ChatMessage copyWith({
    String? id,
    String? author,
    DateTime? timestamp,
    bool? isMe,
    MessageType? type,
    String? text,
    String? voicePath,
    Duration? voiceDuration,
    String? filePath,
    String? fileName,
    int? fileSize,
    FileAttachmentType? fileType,
    List<FileReference>? fileReferences,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      author: author ?? this.author,
      timestamp: timestamp ?? this.timestamp,
      isMe: isMe ?? this.isMe,
      type: type ?? this.type,
      text: text ?? this.text,
      voicePath: voicePath ?? this.voicePath,
      voiceDuration: voiceDuration ?? this.voiceDuration,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      fileType: fileType ?? this.fileType,
      fileReferences: fileReferences ?? this.fileReferences,
    );
  }
}

enum MessageType {
  text,
  voice,
  file,
  textWithReferences, // Text message with file references
}

enum FileAttachmentType {
  image,
  document,
  video,
  audio,
  other,
}

/// Reference to a project file that can be clicked to navigate
class FileReference {
  const FileReference({
    required this.projectId,
    required this.fileName,
    required this.filePath,
    this.fileType,
  });

  final String projectId;
  final String fileName;
  final String filePath;
  final FileAttachmentType? fileType;

  /// Display text for the reference (e.g., "design.pdf", "screenshot.png")
  String get displayName => fileName;

  /// Icon based on file type
  String get icon {
    switch (fileType) {
      case FileAttachmentType.image:
        return '🖼️';
      case FileAttachmentType.document:
        return '📄';
      case FileAttachmentType.video:
        return '🎥';
      case FileAttachmentType.audio:
        return '🎵';
      default:
        return '📎';
    }
  }
}

/// Helper to detect and parse file references in text
class FileReferenceParser {
  FileReferenceParser._();

  /// Pattern: @file[projectId:path/to/file.ext]
  static final _fileRefPattern = RegExp(r'@file\[([^:]+):([^\]]+)\]');

  /// Parse text and extract file references
  static List<FileReference> parse(String text) {
    final matches = _fileRefPattern.allMatches(text);
    return matches.map((match) {
      final projectId = match.group(1)!;
      final filePath = match.group(2)!;
      final fileName = filePath.split('/').last;
      final fileType = _detectFileType(fileName);

      return FileReference(
        projectId: projectId,
        fileName: fileName,
        filePath: filePath,
        fileType: fileType,
      );
    }).toList();
  }

  /// Check if text contains file references
  static bool hasReferences(String text) {
    return _fileRefPattern.hasMatch(text);
  }

  /// Replace file references with placeholders for display
  static String replaceWithPlaceholders(String text) {
    return text.replaceAllMapped(_fileRefPattern, (match) {
      final filePath = match.group(2)!;
      final fileName = filePath.split('/').last;
      return '📎 $fileName';
    });
  }

  static FileAttachmentType _detectFileType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'].contains(ext)) {
      return FileAttachmentType.image;
    }
    if (['mp4', 'mov', 'avi', 'mkv', 'webm'].contains(ext)) {
      return FileAttachmentType.video;
    }
    if (['mp3', 'wav', 'ogg', 'm4a', 'flac'].contains(ext)) {
      return FileAttachmentType.audio;
    }
    if (['pdf', 'doc', 'docx', 'txt', 'xls', 'xlsx', 'ppt', 'pptx'].contains(ext)) {
      return FileAttachmentType.document;
    }
    return FileAttachmentType.other;
  }
}

/// Helper to format file sizes
class FileSizeFormatter {
  FileSizeFormatter._();

  static String format(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
