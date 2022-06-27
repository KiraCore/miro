import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/list_utils.dart';

void main() {
  List<int> numbersList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  group('Tests of getSafeSublist method', () {
    test('Should return 3 first list items', () {
      // Act
      List<int> actualNumbersList = ListUtils.getSafeSublist<int>(list: numbersList, start: 0, end: 3);

      // Assert
      List<int> expectedNumbersList = <int>[1, 2, 3];
      expect(
        actualNumbersList,
        expectedNumbersList,
      );
    });

    test('Should return 3 last list items', () {
      // Act
      List<int> actualNumbersList = ListUtils.getSafeSublist<int>(list: numbersList, start: 7, end: 10);

      // Assert
      List<int> expectedNumbersList = <int>[8, 9, 10];
      expect(
        actualNumbersList,
        expectedNumbersList,
      );
    });

    test('Should return list from start index to last index if end index is bigger than list length', () {
      // Act
      List<int> actualNumbersList = ListUtils.getSafeSublist<int>(list: numbersList, start: 7, end: 15);

      // Assert
      List<int> expectedNumbersList = <int>[8, 9, 10];
      expect(
        actualNumbersList,
        expectedNumbersList,
      );
    });
  });
}
