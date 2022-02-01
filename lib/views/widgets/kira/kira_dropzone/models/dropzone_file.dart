import 'dart:math';

class DropzoneFile {
  final String name;
  final String? extension;
  final String content;
  final int size;

  DropzoneFile({
    required this.name,
    required this.extension,
    required this.content,
    required this.size,
  });

  String get sizeString {
    if (size <= 0) {
      return '0 B';
    }
    final List<String> siSuffixes = <String>['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final int unitIndex = (log(size) / log(1024)).floor();
    final String unitValue = (size / pow(1024, unitIndex)).toStringAsFixed(2);
    return '$unitValue ${siSuffixes[unitIndex]}';
  }
}
