import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';

void main() {
  group('Tests of CustomDateUtils.buildDateFromSecondsSinceEpoch()', () {
    test('Should return [DateTime] for the smallest limiting value (0 seconds)', () {
      // Act
      DateTime actualDateTime = CustomDateUtils.buildDateFromSecondsSinceEpoch(0);

      // Assert
      DateTime expectedDateTime = DateTime.parse('1970-01-01 00:00:00.000Z');
      expect(actualDateTime, expectedDateTime);
    });

    test('Should return [DateTime] for the largest positive limiting value (8 640 000 000 000 seconds)', () {
      // Act
      DateTime actualDateTime = CustomDateUtils.buildDateFromSecondsSinceEpoch(8640000000000);

      // Assert
      DateTime expectedDateTime = DateTime.parse('275760-09-13 00:00:00.000Z');
      expect(actualDateTime, expectedDateTime);
    });

    test('Should return [DateTime] for (1 686 727 887 seconds)', () {
      // Act
      DateTime actualDateTime = CustomDateUtils.buildDateFromSecondsSinceEpoch(1686727887);

      // Assert
      DateTime expectedDateTime = DateTime.parse('2023-06-14 07:31:27.000Z');
      expect(actualDateTime, expectedDateTime);
    });

    test('Should throw [FormatException] if [epoch value NEGATIVE]', () {
      // Assert
      expect(
        () => CustomDateUtils.buildDateFromSecondsSinceEpoch(-1686727887),
        throwsA(isA<FormatException>()),
      );
    });

    test('Should throw [FormatException] if [epoch value LARGER THAN 8640000000000] (DateTime class limit)', () {
      // Assert
      expect(
        () => CustomDateUtils.buildDateFromSecondsSinceEpoch(8640000000001),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('Tests of CustomDateUtils.parseDateToSecondsSinceEpoch()', () {
    test('Should return [0 seconds] for 1970-01-01', () {
      // Arrange
      DateTime actuaDateTime = DateTime.parse('1970-01-01 00:00:00.000Z');

      // Act
      int actualSecondsSinceEpoch = CustomDateUtils.parseDateToSecondsSinceEpoch(actuaDateTime);

      // Assert
      int expectedSecondsSinceEpoch = 0;
      expect(actualSecondsSinceEpoch, expectedSecondsSinceEpoch);
    });

    test('Should return [8 640 000 000 000 seconds] for 275760-09-13 00:00:00.000Z ', () {
      // Arrange
      DateTime actuaDateTime = DateTime.parse('275760-09-13 00:00:00.000Z');

      // Act
      int actualSecondsSinceEpoch = CustomDateUtils.parseDateToSecondsSinceEpoch(actuaDateTime);

      // Assert
      int expectedSecondsSinceEpoch = 8640000000000;
      expect(actualSecondsSinceEpoch, expectedSecondsSinceEpoch);
    });

    test('Should return [1 686 727 887 seconds] for 2023-06-14 07:31:27.000Z', () {
      // Arrange
      DateTime actuaDateTime = DateTime.parse('2023-06-14 07:31:27.000Z');

      // Act
      int actualSecondsSinceEpoch = CustomDateUtils.parseDateToSecondsSinceEpoch(actuaDateTime);

      // Assert
      int expectedSecondsSinceEpoch = 1686727887;
      expect(actualSecondsSinceEpoch, expectedSecondsSinceEpoch);
    });
  });
}
