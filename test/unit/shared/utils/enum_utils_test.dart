import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/enum_utils.dart';

enum TestEnum {
  firstTest,
  secondTest,
}

void main() {
  group('Tests of enumToString() method', () {
    test('Should remove enum name from string and return enum value only', () async {
      expect(
        EnumUtils.parseToString(TestEnum.firstTest),
        'firstTest',
      );
    });
  });
  group('Tests of enumFromString() method', () {
    test('Should return correct enum value based on enum values and name', () async {
      expect(
        EnumUtils.parseFromString(TestEnum.values, 'firstTest'),
        TestEnum.firstTest,
      );
    });
  });
}
