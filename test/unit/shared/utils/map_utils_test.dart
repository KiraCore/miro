import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/map_utils.dart';

void main() {
  // Actual values for tests
  final Map<String, dynamic> actualMapToSort = <String, dynamic>{
    'c_third_key': <String, dynamic>{
      'c_third_key': '2',
      'b_second_key': '3',
      'a_first_key': '4',
    },
    'a_first_key': 'something',
    'b_second_key': <String>[
      '1',
      '2',
      '3',
    ],
  };

  // Expected values for tests
  final Map<String, dynamic> expectedSortedMap = <String, dynamic>{
    'a_first_key': 'something',
    'b_second_key': <String>[
      '1',
      '2',
      '3',
    ],
    'c_third_key': <String, dynamic>{
      'a_first_key': '4',
      'b_second_key': '3',
      'c_third_key': '2',
    },
  };

  group('Tests of MapSorter.sort() method', () {
    test('Should return sorted map', () {
      expect(
        MapUtils.sort(actualMapToSort),
        expectedSortedMap,
      );
    });
  });
}
