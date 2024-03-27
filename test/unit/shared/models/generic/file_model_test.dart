import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/generic/file_model.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/generic/file_model_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of [FileModel.sizeString] getter', () {
    test('Should [return 1 kB] from [1 024 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1024, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1 kB');
    });

    test('Should [return 1.5 kB] from [1536 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1536, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1.5 kB');
    });

    test('Should [return 1 MB] from [1 048 576 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1048576, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1 MB');
    });

    test('Should [return 1.5 MB] from [1 572 864 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1572864, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1.5 MB');
    });

    test('Should [return 1 GB] from [1 073 741 824 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1073741824, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1 GB');
    });

    test('Should [return 1.5 GB] from [1 610 612 736 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1610612736, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1.5 GB');
    });

    test('Should [return 1 TB] from [1 099 511 627 776 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1099511627776, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1 TB');
    });

    test('Should [return 1.5 TB] from [1 649 267 441 664 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1649267441664, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1.5 TB');
    });

    test('Should [return 1 PB] from [1 125 899 906 842 624 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1125899906842624, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1 PB');
    });

    test('Should [return 1.5 PB] from [1 688 849 860 263 936 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1688849860263936, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1.5 PB');
    });

    test('Should [return 1 EB] from [1 152 921 504 606 846 976 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1152921504606846976, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1 EB');
    });

    test('Should [return 1.5 EB] from [1 729 382 256 910 270 464 bytes]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: 1729382256910270464, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(actualFileModel.sizeString, '1.5 EB');
    });

    test('Should [throw assertion error] if size is [negative number]', () {
      // Arrange
      FileModel actualFileModel = const FileModel(size: -1024, name: 'name', content: 'content', extension: 'extension');

      // Assert
      expect(
        () => actualFileModel.sizeString,
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
