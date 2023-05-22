import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:miro/infra/managers/cache/impl/hive_cache_manager.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/managers/cache/hive_cache_manager_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
Future<void> main() async {
  const String actualBoxName = 'testBox';
  await Hive.openBox<String>(actualBoxName);

  late HiveCacheManager actualHiveCacheManager;

  setUp(() {
    actualHiveCacheManager = HiveCacheManager();
  });

  group('Tests of HiveCacheManager.add()', () {
    test('Should return [added value]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue = 'testValue';

      // Act
      await Hive.box<String>(actualBoxName).clear();
      await actualHiveCacheManager.add<String>(boxName: actualBoxName, key: actualKey, value: actualValue);
      dynamic actualCacheValue = Hive.box<String>(actualBoxName).get(actualKey);

      // Assert
      String expectedCacheValue = 'testValue';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should [overwrite] existing value with new value', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue1 = 'testValue1';
      String actualValue2 = 'testValue2';
      await Hive.box<String>(actualBoxName).clear();
      await Hive.box<String>(actualBoxName).put(actualKey, actualValue1);

      // Act
      await actualHiveCacheManager.add<String>(boxName: actualBoxName, key: actualKey, value: actualValue2);
      dynamic actualCacheValue = Hive.box<String>(actualBoxName).get(actualKey);

      // Assert
      String expectedCacheValue = 'testValue2';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of HiveCacheManager.delete()', () {
    test('Should [delete] value if [key exists]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue = 'testValue';
      await Hive.box<String>(actualBoxName).clear();
      await Hive.box<String>(actualBoxName).put(actualKey, actualValue);

      // Act
      await actualHiveCacheManager.delete<String>(boxName: actualBoxName, key: actualKey);
      dynamic actualCacheValue = Hive.box<String>(actualBoxName).get(actualKey);

      // Assert
      expect(actualCacheValue, null);
    });

    test('Should [not delete] any value if [key NOT exists]', () async {
      // Arrange
      String actualKey = 'nonExistingKey';
      await Hive.box<String>(actualBoxName).clear();

      // Act
      await actualHiveCacheManager.delete<String>(boxName: actualBoxName, key: actualKey);
      dynamic actualCacheValue = Hive.box<String>(actualBoxName).get(actualKey);

      // Assert
      expect(actualCacheValue, null);
    });
  });

  group('Tests of HiveCacheManager.deleteAll()', () {
    test('Should [delete all] values in specified box', () async {
      // Arrange
      await Hive.box<String>(actualBoxName).clear();
      await Hive.box<String>(actualBoxName).put('key1', 'value1');
      await Hive.box<String>(actualBoxName).put('key2', 'value2');

      // Act
      await actualHiveCacheManager.deleteAll<String>(boxName: actualBoxName);
      dynamic actualCacheValues = Hive.box<String>(actualBoxName).toMap();

      // Assert
      Map<String, dynamic> expectedCacheValues = <String, dynamic>{};
      expect(actualCacheValues, expectedCacheValues);
    });

    test('Should [not delete] any values if specified [box EMPTY]', () async {
      // Arrange
      await Hive.box<String>(actualBoxName).clear();

      // Act
      await actualHiveCacheManager.deleteAll<String>(boxName: actualBoxName);
      dynamic actualCacheValues = Hive.box<String>(actualBoxName).toMap();

      // Assert
      Map<String, dynamic> expectedCacheValues = <String, dynamic>{};
      expect(actualCacheValues, expectedCacheValues);
    });
  });

  group('Tests of HiveCacheManager.get()', () {
    test('Should return [cached value] if [key exists]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualValue = 'testValue';
      String actualDefaultValue = 'defaultValue';
      await Hive.box<String>(actualBoxName).clear();
      await Hive.box<String>(actualBoxName).put(actualKey, actualValue);

      // Act
      String actualCacheValue = actualHiveCacheManager.get<String>(boxName: actualBoxName, key: actualKey, defaultValue: actualDefaultValue);

      // Assert
      String expectedCacheValue = 'testValue';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should return [default value] if [key NOT exists]', () async {
      // Arrange
      String actualKey = 'testKey';
      String actualDefaultValue = 'defaultValue';
      await Hive.box<String>(actualBoxName).clear();

      // Act
      String actualCacheValue = actualHiveCacheManager.get<String>(boxName: actualBoxName, key: actualKey, defaultValue: actualDefaultValue);

      // Assert
      String expectedCacheValue = 'defaultValue';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of HiveCacheManager.getAll()', () {
    test('Should return [all values] from specified box', () async {
      // Arrange
      await Hive.box<String>(actualBoxName).clear();
      await Hive.box<String>(actualBoxName).put('key1', 'value1');
      await Hive.box<String>(actualBoxName).put('key2', 'value2');

      // Act
      Map<String, String> actualCacheValues = actualHiveCacheManager.getAll<String>(boxName: actualBoxName);

      // Assert
      Map<String, String> expectedCacheValues = <String, String>{
        'key1': 'value1',
        'key2': 'value2',
      };

      expect(actualCacheValues, expectedCacheValues);
    });

    test('Should return [empty map] if specified [box EMPTY]', () async {
      // Arrange
      await Hive.box<String>(actualBoxName).clear();

      // Act
      Map<String, String> actualCacheValues = actualHiveCacheManager.getAll<String>(boxName: actualBoxName);

      // Assert
      Map<String, String> expectedCacheValues = <String, String>{};

      expect(actualCacheValues, expectedCacheValues);
    });
  });
}
