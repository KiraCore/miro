import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/managers/cache/memory_cache_manager_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
void main() {
  const String actualBoxName = 'testBox';
  late MemoryCacheManager actualMemoryCacheManager;

  setUp(() {
    actualMemoryCacheManager = MemoryCacheManager();
  });

  group('Tests of MemoryCacheManager.add()', () {
    test('Should return [added value]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue = 'testValue';

      // Act
      await actualMemoryCacheManager.add<String>(boxName: actualBoxName, key: actualKey, value: actualValue);
      dynamic actualCacheValue = actualMemoryCacheManager.cache[actualBoxName]?[actualKey];

      // Assert
      String expectedCacheValue = 'testValue';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should [overwrite] existing value with new value', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue1 = 'testValue1';
      String actualValue2 = 'testValue2';
      actualMemoryCacheManager.cache[actualBoxName] = <String, String>{};
      actualMemoryCacheManager.cache[actualBoxName]![actualKey] = actualValue1;

      // Act
      await actualMemoryCacheManager.add<String>(boxName: actualBoxName, key: actualKey, value: actualValue2);
      dynamic actualCacheValue = actualMemoryCacheManager.cache[actualBoxName]?[actualKey];

      // Assert
      String expectedCacheValue = 'testValue2';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of MemoryCacheManager.delete()', () {
    test('Should [delete] value if [key exists]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue = 'testValue';
      actualMemoryCacheManager.cache[actualBoxName] = <String, String>{};
      actualMemoryCacheManager.cache[actualBoxName]![actualKey] = actualValue;

      // Act
      await actualMemoryCacheManager.delete<String>(boxName: actualBoxName, key: actualKey);
      dynamic actualCacheValue = actualMemoryCacheManager.cache[actualBoxName]?[actualKey];

      // Assert
      expect(actualCacheValue, null);
    });

    test('Should [NOT delete] any value if [key NOT exists]', () async {
      // Arrange
      String actualKey = 'nonExistingKey';

      // Act
      await actualMemoryCacheManager.delete<String>(boxName: actualBoxName, key: actualKey);
      dynamic actualCacheValue = actualMemoryCacheManager.cache[actualBoxName]?[actualKey];

      // Assert
      expect(actualCacheValue, null);
    });
  });

  group('Tests of MemoryCacheManager.deleteAll()', () {
    test('Should [delete all] values in specified box', () async {
      // Arrange
      actualMemoryCacheManager.cache[actualBoxName] = <String, String>{
        'key1': 'value1',
        'key2': 'value2',
      };

      // Act
      await actualMemoryCacheManager.deleteAll<String>(boxName: actualBoxName);
      dynamic actualCacheValues = actualMemoryCacheManager.cache[actualBoxName];

      // Assert
      Map<String, dynamic> expectedCacheValues = <String, dynamic>{};
      expect(actualCacheValues, expectedCacheValues);
    });

    test('Should [NOT delete] any values if specified [box EMPTY]', () async {
      // Act
      await actualMemoryCacheManager.deleteAll<String>(boxName: actualBoxName);
      dynamic actualCacheValues = actualMemoryCacheManager.cache[actualBoxName];

      // Assert
      Map<String, dynamic> expectedCacheValues = <String, dynamic>{};
      expect(actualCacheValues, expectedCacheValues);
    });
  });

  group('Tests of MemoryCacheManager.get()', () {
    test('Should return [cached value] if [key exists]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue = 'testValue';
      String actualDefaultValue = 'defaultValue';
      actualMemoryCacheManager.cache[actualBoxName] = <String, String>{};
      actualMemoryCacheManager.cache[actualBoxName]![actualKey] = actualValue;

      // Act
      String actualCacheValue = actualMemoryCacheManager.get<String>(boxName: actualBoxName, key: actualKey, defaultValue: actualDefaultValue);

      // Assert
      String expectedCacheValue = 'testValue';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should return [default value] if [key NOT exists]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualDefaultValue = 'defaultValue';

      // Act
      String actualCacheValue = actualMemoryCacheManager.get<String>(boxName: actualBoxName, key: actualKey, defaultValue: actualDefaultValue);

      // Assert
      String expectedCacheValue = 'defaultValue';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of MemoryCacheManager.getAll()', () {
    test('Should return [all values] from specified box', () async {
      // Arrange
      actualMemoryCacheManager.cache[actualBoxName] = <String, String>{
        'key1': 'value1',
        'key2': 'value2',
      };

      // Act
      Map<String, String> actualCacheValues = actualMemoryCacheManager.getAll<String>(boxName: actualBoxName);

      // Assert
      Map<String, String> expectedCacheValues = <String, String>{
        'key1': 'value1',
        'key2': 'value2',
      };

      expect(actualCacheValues, expectedCacheValues);
    });

    test('Should return [empty map] if specified [box EMPTY]', () async {
      // Act
      Map<String, String> actualCacheValues = actualMemoryCacheManager.getAll<String>(boxName: actualBoxName);

      // Assert
      Map<String, String> expectedCacheValues = <String, String>{};

      expect(actualCacheValues, expectedCacheValues);
    });
  });
}
