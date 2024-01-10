import 'dart:async';
import 'dart:html' as html;
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

class FileModel extends Equatable {
  final int size;
  final String name;
  final String content;
  final String? extension;

  const FileModel({
    required this.size,
    required this.name,
    required this.content,
    required this.extension,
  });

  factory FileModel.fromPlatformFile(PlatformFile platformFile) {
    final List<int> fileBytes = platformFile.bytes ?? List<int>.empty();
    return FileModel(
      name: platformFile.name,
      size: platformFile.size,
      extension: platformFile.extension,
      content: String.fromCharCodes(fileBytes),
    );
  }

  static Future<FileModel> fromHtmlFile(html.File htmlFile) async {
    final Completer<FileModel> kiraDropzoneFileModelCompleter = Completer<FileModel>();
    final html.FileReader htmlFileReader = html.FileReader()..readAsText(htmlFile);
    final StreamSubscription<dynamic> fileUploadStream = htmlFileReader.onLoadEnd.listen((_) {
      String result = htmlFileReader.result.toString();
      FileModel kiraDropzoneFileModel = FileModel(
        name: htmlFile.name,
        size: htmlFile.size,
        extension: htmlFile.name.split('.').last,
        content: result,
      );
      kiraDropzoneFileModelCompleter.complete(kiraDropzoneFileModel);
    });
    FileModel kiraDropzoneFileModel = await kiraDropzoneFileModelCompleter.future;
    await fileUploadStream.cancel();
    return kiraDropzoneFileModel;
  }

  String get sizeString {
    assert(size >= 0, 'File size must be greater than or equal to 0');
    List<String> siSuffixes = <String>['B', 'kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    int unitIndex = (log(size) / log(1024)).floor();
    num unitValue = size / pow(1024, unitIndex);
    String unitString = unitValue.toStringAsFixed(1);
    if (unitValue.toStringAsFixed(1).endsWith('.0')) {
      unitString = unitValue.toInt().toString();
    }
    return '$unitString ${siSuffixes[unitIndex]}';
  }

  @override
  List<Object?> get props => <Object?>[name, extension, content, size];
}
