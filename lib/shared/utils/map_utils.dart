import 'dart:collection';

class MapUtils {
  /// Takes the given [map] and orders its values based on their keys.
  /// Returns the sorted map.
  static Map<String, dynamic> sort(Map<String, dynamic> map) {
    // Get the sorted keys
    final List<String> sortedKeys = map.keys.toList()..sort();

    // Sort each value
    final SplayTreeMap<String, dynamic> result = SplayTreeMap<String, dynamic>();
    for (String key in sortedKeys) {
      result[key] = _encodeValue(map[key]);
    }

    return result;
  }

  /// Takes a generic [value] and returns its sorted representation.
  /// * If it is a map, [sort] is called.
  /// * If it is a list, [_encodeList] is called.
  /// * Otherwise, the same value is returned.
  static dynamic _encodeValue(dynamic value) {
    if (value is Map) {
      return sort(value as Map<String, dynamic>);
    } else if (value is List) {
      return _encodeList(value);
    }
    return value;
  }

  /// Takes the given [value] and orders each one of the contained
  /// items that are present inside it by calling [_encodeValue].
  static List<dynamic> _encodeList(dynamic value) {
    final List<dynamic> result = <dynamic>[];
    for (dynamic item in value.cast<dynamic>()) {
      result.add(_encodeValue(item));
    }
    return result;
  }
}
