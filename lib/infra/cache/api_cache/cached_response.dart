import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'cached_response.g.dart';

@HiveType(typeId: 1)
class CachedResponse extends Equatable {
  @HiveField(0)
  final String key;
  @HiveField(1)
  final int maxAgeMilliseconds;
  @HiveField(2)
  final String? content;
  @HiveField(3)
  final int? statusCode;
  @HiveField(4)
  final String? headers;

  const CachedResponse({
    required this.key,
    required this.statusCode,
    required this.maxAgeMilliseconds,
    this.content,
    this.headers,
  });

  factory CachedResponse.init({
    required String key,
    required Duration maxAge,
    int? statusCode,
    String? content,
    String? headers,
  }) {
    return CachedResponse(
      key: key,
      statusCode: statusCode,
      maxAgeMilliseconds: DateTime.now().add(maxAge).millisecondsSinceEpoch,
      content: content,
      headers: headers,
    );
  }

  factory CachedResponse.empty() {
    return const CachedResponse(
      key: '',
      statusCode: null,
      maxAgeMilliseconds: 0,
      content: null,
      headers: null,
    );
  }

  bool get expired {
    int now = DateTime.now().millisecondsSinceEpoch;
    return maxAgeMilliseconds < now;
  }

  @override
  List<Object?> get props => <Object?>[key, content];

  @override
  String toString() {
    return 'CachedResponse{key: $key, maxAgeDate: $maxAgeMilliseconds, content: ${(content?.length ?? 0) > 200 ? content?.substring(0, 200) : content}, statusCode: $statusCode, headers: $headers}';
  }
}
