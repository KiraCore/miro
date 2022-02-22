import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/string_utils.dart';

void main() {
  group('Tests of compareStrings() method', () {
    test('Should return true if text contains formatted pattern', () {
      expect(
        StringUtils.compareStrings('Zażółć gęślą jaźń', 'ges'),
        true,
      );
    });
    test('Should remove blank spaces and return true', () {
      expect(
        StringUtils.compareStrings('Genesis of Decentralized Finance', 'sisof'),
        true,
      );
    });
    test('Should return true if text contains formatted pattern', () {
      expect(
        StringUtils.compareStrings('Zażółć gęślą jaźń', 'GęŚląJAzŃ'),
        true,
      );
    });
  });
}
